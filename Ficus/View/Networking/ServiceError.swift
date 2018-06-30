//
//  ServiceError.swift
//  Ficus
//
//  Created by Yeral Yamil Castillo on 6/30/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation

enum ServiceError: Error{
    case noInternetConnection
    case serverNotFound
    case custom(String)
}

extension ServiceError{
    var description: String{
        get{
            switch self {
            case .noInternetConnection:
                return "The Internet connection is not available"
            case .serverNotFound:
                return "The server was not found"
            case .custom(let message):
                return message
            }
        }
    }
}
