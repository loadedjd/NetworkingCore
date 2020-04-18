//
//  Resource.swift
//  Bingo
//
//  Created by Jared Williams on 4/10/20.
//  Copyright © 2020 Forlefac Fontem. All rights reserved.
//

import Foundation

/*
    A composable datasource
 
        - Paramter path: The relative path to your datasource
        - Paramter method: The http method to use for your datasource
        - Paramter parameters: The body parameters to be used for your datasource
        - Paramter headers: The header parameters to be used for your datasource
        - Paramter returnType: The type used to decode the response of your datasource
*/

public struct Datasource<ReturnType: Codable> {
        
    public var path: String?
    
    public var method: HTTPMethod?
    
    public var parameters: ParamsProvider.Type?
    
    public var headers: HeadersProvider.Type?
    
    public var returnType: ReturnType.Type?
    
    public var consumer: Consumer.Type?
    
    public var datasourceType: String?
    
    public init(path: String, method: HTTPMethod, parameters: ParamsProvider.Type?, headers: HeadersProvider.Type?, returnType: ReturnType.Type, consumer: Consumer.Type, datasourceType: String?) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.returnType = returnType
        self.consumer = consumer
        self.datasourceType = datasourceType
    }
}

public enum DatasourceType {
    // This is left intentionally blank
    // The idea is for the client of the library to be able to extend this enum
    // to setup default names for the associated datasource
    // Something like the follwing
    // case .signUp(Datasource(...))
}

public struct ApiResponse: Codable {
    public var status: String?
}


