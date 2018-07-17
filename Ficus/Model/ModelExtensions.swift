//
//  ModelExtensions.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/16/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation

protocol Descripting {
    var description: String { get }
}

extension Car: Descripting {
    var description: String {
        get {
            return "\(carCategory.name) - \(comparisonText)"
        }
    }
}

extension ElectricityPriceDetail: Descripting {
    var description: String {
        get {
            return "\(type) - \(price)"
        }
    }
}
