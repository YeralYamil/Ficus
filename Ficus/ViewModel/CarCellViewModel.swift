//
//  CellViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/17/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

class CarCellViewModel {
    
    private let gasPrice = 1.3 //TODO: Hard coded for now, change later
  
    struct Input {
        let price: Observable<String?>
        let efficiency: Observable<String?>
    }
    
    struct Output {
        let formattedCost: Observable<String>
        let cost: Observable<Double>
    }
    
    private var input: Input?
    var output: Output?
    var price: String {
        get {
            if self.car.type == .electric,
                let electricityPriceDetail = self.electricityPriceDetail {
                return "\(electricityPriceDetail.price)"
            }
            return "\(gasPrice)"
        }
    }
    var efficiency: String {
        get {
            return "\(car.efficiency)"
        }
    }
    var carType: CarType {
        get {
            return car.type
        }
    }
    
    private let car: Car
    private let electricityPriceDetail: ElectricityPriceDetail?
    
    init(car: Car, electricityPriceDetail: ElectricityPriceDetail? = nil) {
        self.car = car
        self.electricityPriceDetail = electricityPriceDetail
    }
    
    func transform(input: Input) -> Output {
        self.input = input
        
        let cost = Observable.combineLatest(input.price, input.efficiency) { (price, efficiency) -> Double in
            guard let priceString = price,
                let efficiencyString = efficiency,
                let numericPrice = Double(priceString),
                let numericEfficiency = Double(efficiencyString) else {
                    return 0
            }
            return numericPrice * numericEfficiency
        }
        
        let formattedCost = cost
            .map { (cost) -> String in
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                guard let costString = formatter.string(from: NSNumber(value: cost)) else { return "" }

                return costString
            }
        
        let output = Output(formattedCost: formattedCost, cost: cost)
        self.output = output
        
        return output
    }

}
