//
//  DataCollection.swift
//  Bingo
//
//  Created by Jared Williams on 4/10/20.
//  Copyright © 2020 Forlefac Fontem. All rights reserved.
//

import Foundation

public protocol DataCollection {

    associatedtype DatasourceType
    
    var datasources: [DatasourceType]? { get set }
}

