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

public class Core {
    static func executeDatasource<T: Codable>(datasource: Datasource<T>, for enviroment: Enviroment, completion: @escaping (Swift.Result<T, NetworkError>) -> Void) {
        
        guard let hostString = enviroment.hostString else { return }
        guard var hostUrl = URL(string: hostString) else { return }
        guard let apiString = enviroment.apiString else { return }
        guard let dataPath = datasource.path else { return }
        let returnType = datasource.returnType
        
        let method = datasource.method ?? .get
        
        
        hostUrl.appendPathComponent(apiString)
        hostUrl.appendPathComponent(dataPath)
        
        switch method {
        case .get:
            AF.request(hostUrl).response { (response: AFDataResponse<Data?>) in
                
                guard let data = response.data else {
                    
                    // TODO: - If this goes wrong then interrogate the ressponse object to return the correct error
                    completion(.failure(.badUrl))
                    return
                    
                }
                
                guard response.error == nil else {
                    
                    completion(.failure(.badUrl))
                    return
                }
                
                guard let decodedModel: T = decodeJson(data: data) else {
                    completion(.failure(.badUrl))
                    return
                }
                
                completion(.success(decodedModel))
            }
            
        
        default:
            break
        }
        
    }
    
    private static func decodeJson<T: Codable> (data: Data) -> T? {
        
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
}
