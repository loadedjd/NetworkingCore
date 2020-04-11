//
//  HTTP.swift
//  NetworkingCore
//
//  Created by Jared Williams on 4/10/20.
//  Copyright © 2020 Forlefac Fontem. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]

public typealias HTTPParameters = [String : Any?]

public enum HTTPMethod {
    case get
    case post
    case put
    case delete
}
