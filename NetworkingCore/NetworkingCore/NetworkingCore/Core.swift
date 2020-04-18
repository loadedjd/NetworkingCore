//
//  Core.swift
//  Bingo
//
//  Created by Jared Williams on 4/10/20.
//  Copyright © 2020 Forlefac Fontem. All rights reserved.
//

import Foundation
import Alamofire


typealias NetworkCompletionHandler = (Swift.Result<Data, NetworkError>) -> Void

open class Core {
    
    private static var _registeredDatasources: [Any?] = []
    private static var operatingEnviroment: Enviroment?
    
    public static func registerDatasource<T: Codable>(datasource: Datasource<T>) {
        self._registeredDatasources.append(datasource)
    }
    
    public static func registerEnviroment(enviroment: Enviroment) {
        Core.operatingEnviroment = enviroment
    }
    
    public static func go<T: Codable>(datasourceType: String, returnType: T.Type, completion: @escaping (NetworkError) -> Void) {
        
        let matchingSources = (Core._registeredDatasources as? [Datasource<T>])?.filter() { (ds: Datasource<T>) in
            return (ds.datasourceType ?? "") == datasourceType
        }
        
        guard let firstMatch = matchingSources?.first else { return }
        
        guard let enviroment = Core.operatingEnviroment else { return }
        
        Core.executeDatasource(datasource: firstMatch, for: enviroment, completion: completion)
    }
    
    private static func executeDatasource<T: Codable>(datasource: Datasource<T>, for enviroment: Enviroment, completion: @escaping (NetworkError) -> Void) {
        
        guard let hostString = enviroment.hostString else { return }
        guard var hostUrl = URL(string: hostString) else { return }
        guard let apiString = enviroment.apiString else { return }
        guard let dataPath = datasource.path else { return }
        
        let method = datasource.method ?? .get
        let headers = datasource.headers?.provide() ?? [:]
        let body = datasource.parameters?.provide() ?? [:]
        
        hostUrl.appendPathComponent(apiString)
        hostUrl.appendPathComponent(dataPath)
                        
        switch method {
        case .get:
            AF.request( hostUrl, headers: convertHeadersToHTTPHeaders(headers: headers) ).response { (response: AFDataResponse<Data?>) in
                
                let vaildatedResponse: Swift.Result<T, NetworkError> = validateResponse(response: response)
                
                switch vaildatedResponse {
                case .success(let decodedModel):
                    datasource.consumer?.consume(result: decodedModel)
                    
                case .failure(let error):
                    completion(error)
                }
            }
            
        case .post:
            AF.request(hostUrl, method: .post, parameters: body, encoding: JSONEncoding.default, headers: convertHeadersToHTTPHeaders(headers: headers)).response { (response: AFDataResponse<Data?>) in
                
                let vaildatedResponse: Swift.Result<T, NetworkError> = validateResponse(response: response)
                
                switch vaildatedResponse {
                case .success(let decodedModel):
                    datasource.consumer?.consume(result: decodedModel)
                    
                case .failure(let error):
                    completion(error)
                }
            }
            
        case .put:
            AF.request(hostUrl, method: .put, parameters: body, encoding: JSONEncoding.default, headers: convertHeadersToHTTPHeaders(headers: headers)).response { (response: AFDataResponse<Data?>) in
                
                let vaildatedResponse: Swift.Result<T, NetworkError> = validateResponse(response: response)
                
                switch vaildatedResponse {
                case .success(let decodedModel):
                    datasource.consumer?.consume(result: decodedModel)
                    
                case .failure(let error):
                    completion(error)
                }
            }
            
        case .delete:
            AF.request(hostUrl, method: .delete, parameters: body, encoding: JSONEncoding.default, headers: convertHeadersToHTTPHeaders(headers: headers)).response { (response: AFDataResponse<Data?>) in
                
                let vaildatedResponse: Swift.Result<T, NetworkError> = validateResponse(response: response)
                
                switch vaildatedResponse {
                case .success(let decodedModel):
                    datasource.consumer?.consume(result: decodedModel)
                    
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
    
    private static func decodeJson<T: Codable> (data: Data) -> T? {
        
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
    
    private static func convertHeadersToHTTPHeaders(headers: [String : String]) -> Alamofire.HTTPHeaders{
        let httpHeaders = headers.map { (key, value) -> HTTPHeader in
            return HTTPHeader(name: key, value: value)
        }
        
        let afHeaders = Alamofire.HTTPHeaders(httpHeaders)
        
        return afHeaders
    }
    
    private static func validateResponse<T: Codable>(response: AFDataResponse<Data?>) -> Swift.Result<T, NetworkError> {
        guard let data = response.data else {
            // TODO: - If this goes wrong then interrogate the ressponse object to return the correct error
            return .failure(.badUrl)
        }
        
        guard response.error == nil else {
            
            return .failure(.responseError)
        }
        
        guard let decodedModel: T = decodeJson(data: data) else {
            return .failure(.decode)
        }
        
        return .success(decodedModel)
    }
}
