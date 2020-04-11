//
//  Resource.swift
//  Bingo
//
//  Created by Jared Williams on 4/10/20.
//  Copyright © 2020 Forlefac Fontem. All rights reserved.
//

import Foundation

public struct Datasource<ReturnType: Codable> {
        
    var path: String?
    
    var method: HTTPMethod?
    
    var parameter: HTTPParameters?
    
    var headers: HTTPHeaders?
    
    var returnType: ReturnType?
}

//var userDS = Datasource<AuthApiResponse>()


//public struct GetUser: Datasource {
//
//
//    public var path: String? = "/user"
//
//    public var method: HTTPMethod? = .get
//
//    public var parameter: HTTPParameters? = nil
//
//    public var headers: HTTPHeaders? = nil
//
//    public var returnType: Codable.Type = AuthApiResponse.self
//
//}

public struct AuthApiResponse: Codable {
    var name: String?
}

public struct test: Codable {
    var name: String?
}

