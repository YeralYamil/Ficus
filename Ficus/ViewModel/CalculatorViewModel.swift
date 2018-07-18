//
//  CalculatorViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

class CalculatorViewModel {
    
    struct Input {
        let distance: Observable<String?>
    }
    
    struct Output {
        let savings: Observable<String>
    }
    
    private let electricCar: Car
    private let gasCar: Car
    private let electricityPriceDetail: ElectricityPriceDetail
    private var input: Input? = nil
    private var output: Output? = nil
    
    var electricCarCellViewModel: CarCellViewModel
    var gasCarCellViewModel: CarCellViewModel
    
    init(electricCar: Car, gasCar: Car, electricityPriceDetail: ElectricityPriceDetail) {
        self.electricCar = electricCar
        self.gasCar = gasCar
        self.electricityPriceDetail = electricityPriceDetail
        
        self.electricCarCellViewModel = CarCellViewModel(car: electricCar, electricityPriceDetail: electricityPriceDetail)
        self.gasCarCellViewModel = CarCellViewModel(car: gasCar)
    }
    
    func transform(input: Input) -> Output {
        self.input = input
        
        let savings = Observable.combineLatest(self.electricCarCellViewModel.output!.cost, self.gasCarCellViewModel.output!.cost, input.distance) { (electricCost, gasCost, distance) -> String in
            guard let distanceString = distance,
                let numericDistance = Double(distanceString) else { return "" }
            let savings = (electricCost - gasCost) * numericDistance
            return "$ \(savings) per year travelling \(numericDistance) km"
        }
        let output = Output(savings: savings)
        self.output = output
        return output
    }
    
}
