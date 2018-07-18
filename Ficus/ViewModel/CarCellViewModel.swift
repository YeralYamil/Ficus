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
        let formattedPrice: Observable<String>
        let formattedEfficiency: Observable<String>
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
    
    
    private let car: Car
    private let electricityPriceDetail: ElectricityPriceDetail?
    
    init(car: Car, electricityPriceDetail: ElectricityPriceDetail? = nil) {
        self.car = car
        self.electricityPriceDetail = electricityPriceDetail
    }
    
    func transform(input: Input) -> Output {
        self.input = input
        
        let formattedPrice = input.price.map { price -> String in
            return price ?? ""
        }
        let formattedEfficiency = input.efficiency.map { efficiency -> String in
            guard let efficiency = efficiency else { return "" }
            if (self.car.type == .electric) {
                return "\(efficiency)"
            }
            return "\(efficiency)"
        }
        
        let cost = Observable.combineLatest(input.price, input.efficiency) { (price, efficiency) -> Double in
            guard let priceString = price,
                let efficiencyString = efficiency,
                let numericPrice = Double(priceString),
                let numericEfficiency = Double(efficiencyString) else {
                    return 0
            }
            return numericPrice * numericEfficiency
        }
        
        let formattedCost = cost.map { "$\($0)" }
        
        let output = Output(formattedPrice: formattedPrice, formattedEfficiency: formattedEfficiency, formattedCost: formattedCost, cost: cost)
        self.output = output
        
        return output
    }
    
    
}
