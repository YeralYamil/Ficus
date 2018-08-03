//
//  CalculatorViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

class CalculatorViewModel: ViewModel {
    
    struct Input {
        let distance: Observable<String>
    }
    
    struct Output {
        let savings: Observable<Double>
    }
    
    private let electricCar: Car
    private let gasCar: Car
    private let electricityPriceDetail: ElectricityPriceDetail
    private var output: Output? = nil
    
    private let electricCarCellViewModel: CarCellViewModel
    private let gasCarCellViewModel: CarCellViewModel
    
    var carCellViewModelsObservable: Observable<[CarCellViewModel]> {
        get {
            return Observable<[CarCellViewModel]>.just([electricCarCellViewModel, gasCarCellViewModel])
        }
    }
    
    init(electricCar: Car, gasCar: Car, electricityPriceDetail: ElectricityPriceDetail) {
        self.electricCar = electricCar
        self.gasCar = gasCar
        self.electricityPriceDetail = electricityPriceDetail
        
        self.electricCarCellViewModel = CarCellViewModel(car: electricCar, electricityPriceDetail: electricityPriceDetail)
        self.gasCarCellViewModel = CarCellViewModel(car: gasCar)
    }
    
    func transform(input: Input) -> Output? {
        guard let electricCarOutput = self.electricCarCellViewModel.output,
            let gasCarOutput = self.gasCarCellViewModel.output else { return nil }
        let savings = Observable
            .combineLatest(electricCarOutput.cost, gasCarOutput.cost, input.distance) { (electricCost, gasCost, distance) -> Double in
                guard let numericDistance = Double(distance) else { return 0 }
                let savings = (gasCost - electricCost) * numericDistance / 100
                return savings
            }
        
        
        self.output = Output(savings: savings)
        return self.output
    }
    
}
