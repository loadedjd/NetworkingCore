//
//  Enviroment.swift
//  Bingo
//
//  Created by Jared Williams on 4/10/20.
//  Copyright © 2020 Forlefac Fontem. All rights reserved.
//

import Foundation

//private enum Enviroment: String {
//    case dev = "http://localhost:3000/api"
//    case prod = "https://doggo-api.herokuapp.com/api"
//}

public protocol Enviroment {
    var hostString: String? { get set }
    var apiString: String? { get set }
    
    init(hostString: String, apiString: String?)
}

public struct DevV1Enviroment: Enviroment {
    public var hostString: String? = "http://localhost:3000/api"
    public var apiString: String? = "/v1"
    
    public init(hostString: String, apiString: String?) {
        self.hostString = hostString
        self.apiString = apiString
    }
}

public struct DevV2Enviroment: Enviroment {
    public var hostString: String? = "http://localhost:3000/api"
    public var apiString: String? = "/v2"
    
    public init(hostString: String, apiString: String?) {
        self.hostString = hostString
        self.apiString = apiString
    }
}

public struct ProdV1Enviroment: Enviroment {
    public var hostString: String? = "https://doggo-api.herokuapp.com/api"
    public var apiString: String? = "/v1"
    
    public init(hostString: String, apiString: String?) {
        self.hostString = hostString
        self.apiString = apiString
    }
}

public struct ProdV2Enviroment: Enviroment {
    public var hostString: String? = "https://doggo-api.herokuapp.com/api"
    public var apiString: String? = "/v2"
    
    public init(hostString: String, apiString: String?) {
        self.hostString = hostString
        self.apiString = apiString

    }
}

public struct TestEnviroment: Enviroment {
    public var hostString: String? = "http://dummy.restapiexample.com/api"
    public var apiString: String? = "/v1"
    
    public init(hostString: String, apiString: String?) {
        self.hostString = hostString
        self.apiString = apiString
    }
}
