//
//  Consumer.swift
//  NetworkingCore
//
//  Created by Jared Williams on 4/17/20.
//  Copyright © 2020 Doggo Insurance. All rights reserved.
//

import Foundation

public protocol Consumer {
    static func consume(result: Codable)
}

public struct ResponseConsumer: Consumer {
    public static func consume(result: Codable) {
        guard let res = result as? ApiResponse else { return }
        print("Consumer \(res.status ?? "")")
    }
}
