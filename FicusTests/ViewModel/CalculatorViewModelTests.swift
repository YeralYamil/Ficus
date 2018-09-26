//
//  CalculatorViewModelTests.swift
//  FicusTests
//
//  Created by Yeral Yamil on 9/25/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import XCTest
@testable import Ficus
import RxSwift
import RxTest

let electricityPrice: Double = 0.10 // $ per kwh
let gasPrice: Double = 1.25 // $ per kwh

class CalculatorViewModelTests: XCTestCase {
    
    
    private let gasPrice = 1.25
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOutput_CalculatesSavings() {
        //Given
        let electricCar = createElectricCar()
        let gasCar = createGasCar()
        let electricityPriceDetail = createElectricityPriceDetail()
        
        let electricCarViewModel = CarCellViewModelMock(car: electricCar, electricityPriceDetail: electricityPriceDetail)
        let gasCarViewModel = CarCellViewModelMock(car: gasCar)
        
        let sut = CalculatorViewModel(electricCar: electricCar, gasCar: gasCar, electricityPriceDetail: electricityPriceDetail, electricCarCellViewModel:electricCarViewModel, gasCarCellViewModel: gasCarViewModel)
        
        let scheduler = TestScheduler(initialClock: 0)
        
        //When
        let distanceObservable = scheduler.createHotObservable([
            next(210, "10000"),
            next(220, "20000"),
            ]).asObservable()
        let input = CalculatorViewModel.Input(distance: distanceObservable)
        guard let output = sut.transform(input: input) else { XCTFail("Output should not be nil"); return }
        
        //Then
        let res = scheduler.start { output.savings }
        XCTAssertRecordedElements(res.events, [852.5, 1705.0])
    }
    
    func createElectricityPriceDetail() -> ElectricityPriceDetail {
        
        let electricityPriceDetail = ElectricityPriceDetail.init(type: "Off-peak", price: electricityPrice)
        return electricityPriceDetail
    }
    
    func createElectricCar() -> Car {
        return createCar(carType: .electric, efficiency: 21)
    }
    
    func createGasCar() -> Car {
        return createCar(carType: .gas, efficiency: 8.5)
    }
    
    func createCar(carType: CarType, efficiency: Double)  -> Car {
        let carCategory = CarCategory(name: "Compact", id: "1")
        let efficiencyType = carType == .electric ? EfficiencyType.kwhP100km : EfficiencyType.lp100km
        let car = Car(carCategory: carCategory, comparisonText: "Nissan leaf or similar", efficiency: efficiency, efficiencyType: efficiencyType, type: carType, kgCo2PerLiter: 0.20)
        
        return car
    }
    
}

class CarCellViewModelMock: CarCellViewModelProtocol {
    
    var output: CarCellViewModel.Output? = nil
    var price: String {
        get {
            return ""
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
        self.output = transform(input: CarCellViewModel.Input(price: Observable.just(""), efficiency: Observable.just("")))
    }
    
    func transform(input: CarCellViewModel.Input) -> CarCellViewModel.Output? {
        
        let price = self.electricityPriceDetail?.price ?? gasPrice
        let cost = price * car.efficiency
        
        let output = CarCellViewModel.Output(formattedCost: Observable.just(""), cost: Observable.just(cost), kgCO2PerLiter: Observable.just(0))
        
        return output
    }
    
    
}
