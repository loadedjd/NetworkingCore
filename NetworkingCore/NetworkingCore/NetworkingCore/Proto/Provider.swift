//
//  Provider.swift
//  NetworkingCore
//
//  Created by Jared Williams on 4/17/20.
//  Copyright © 2020 Doggo Insurance. All rights reserved.
//

import Foundation

public protocol ParamsProvider {
    static func provide() -> [String : Any]
}

public struct UserParamsProvider: ParamsProvider {
    public static func provide() -> [String : Any] {
        return ["Age" : 21]
    }
}

public protocol HeadersProvider {
    static func provide() -> [String : String]
}

public struct TokenProvider: HeadersProvider {
    public static func provide() -> [String : String] {
        return ["token" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozMDEsImlhdCI6MTU4NzE0MjgzNSwiZXhwIjoxNTg3MjQyODM1fQ.vJyszrZ4H4ray9j-bRnAaEUftqbvxHEj3Abdp4iZ06U"]
    }
}

struct User: Codable {
    var name: String?
    var age: Int?
}
