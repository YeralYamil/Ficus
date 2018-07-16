//
//  CalculatorViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation

class CalculatorViewModel {
    
    let electricCar: Car!
    let gasCar: Car!
    let electricityPriceDetail: ElectricityPriceDetail!
    
    init(electricCar: Car, gasCar: Car, electricityPriceDetail: ElectricityPriceDetail) {
        self.electricCar = electricCar
        self.gasCar = gasCar
        self.electricityPriceDetail = electricityPriceDetail
        
        print(electricCar)
    }
    
    
}
