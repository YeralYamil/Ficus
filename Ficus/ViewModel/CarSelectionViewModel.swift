//
//  CarSelectionViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/9/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources


class CarSelectionViewModel: NSObject {
    
    struct Input {
        let electricCar: Observable<[Car]>
        let gasCar: Observable<[Car]>
        let electricityPriceDetail: Observable<[ElectricityPriceDetail]>
    }
    
    struct Output {
        let electricCarText = Variable<String>("")
        let gasCarText = Variable<String>("")
        let electricityPriceText = Variable<String>("")
    }
    
    //Move to a service class
    
    private var electricityProvider: ElectricityProvider?
    private var input: Input?
    private let disposeBag = DisposeBag()
    private(set) var service: Service
    
    var selectedElectricCar: Car? = nil
    var selectedGasCar: Car? = nil
    var selectedElectricityPriceDetail: ElectricityPriceDetail? = nil
    
    let gasCars: Variable<[Car]> = Variable([])
    let electricCars: Variable<[Car]> = Variable([])
    let electricityPricesDetail: Variable<[ElectricityPriceDetail]> = Variable([])
    let output = Output()
    
    init(service: Service = FicusService()) {
        self.service = service
        super.init()
        self.loadAllCars()
        self.loadElectricityPrice()
    }
    
    private func loadAllCars() {
        
        service.loadCars { (cars, error) in
            if let error = error { print(error) }
            guard let cars = cars else { return }
                
            self.gasCars.value = cars.filter({ $0.type == CarType.gas })
            self.electricCars.value = cars.filter({ $0.type == CarType.electric })
            
            if let firstElectricCar = self.electricCars.value.first {
                self.selectedElectricCar = firstElectricCar
                self.output.electricCarText.value = firstElectricCar.description
            }
            
            if let firstGasCar = self.gasCars.value.first {
                self.selectedGasCar = firstGasCar
                self.output.gasCarText.value = firstGasCar.description
            }
        }
    }
    
    private func loadElectricityPrice() {
        service.loadElectrivityProvider { (electricityProvider, error) in
            if let error = error { print(error) }
            guard let electricityProvider = electricityProvider,
                  let electricityPricesDetail = electricityProvider.electricityPriceDetails else { return }
            
            self.electricityProvider = electricityProvider
            self.electricityPricesDetail.value = electricityPricesDetail
            if let firstElectricityPriceDetail = electricityPricesDetail.first {
                self.selectedElectricityPriceDetail = firstElectricityPriceDetail
                self.output.electricityPriceText.value = firstElectricityPriceDetail.description
            }
        }
    }
    
    func transform(input: Input) -> Output {
        self.input = input
        input.electricCar
            .subscribe(onNext: { (cars) in
                guard let car = cars.first else {
                    return
                }
                self.selectedElectricCar = car
                self.output.electricCarText.value = car.description
            })
            .disposed(by: disposeBag)
        input.gasCar
            .subscribe(onNext: { cars in
                guard let car = cars.first else {
                    return
                }
                self.selectedGasCar = car
                self.output.gasCarText.value = car.description
            })
            .disposed(by: disposeBag)
        input.electricityPriceDetail
            .subscribe(onNext: { electricityPricesDetail in
                guard let electricityPriceDetail = electricityPricesDetail.first else {
                    return
                }
                self.selectedElectricityPriceDetail = electricityPriceDetail
                self.output.electricityPriceText.value = electricityPriceDetail.description
            })
            .disposed(by: disposeBag)
        
        return self.output
    }

}
