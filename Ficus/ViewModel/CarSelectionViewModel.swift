//
//  CarSelectionViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/9/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift
import Apollo
import RxDataSources


class CarSelectionViewModel: NSObject {
    
    struct Adapters {
        let electricCar = CarPickerAdapter.create()
        let gasCar = CarPickerAdapter.create()
        let electricityPriceDetail = ElectricityPriceDetailAdapter.create()
    }
    
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
    private let apollo = ApolloClient(url: URL(string: "https://api.graph.cool/simple/v1/cjj3nnfwq52jh0115681afinu")!)
    private var electricityProvider: ElectricityProvider?
    private var input: Input!
    private let disposeBag = DisposeBag()
    
    var selectedElectricCar: Car? = nil
    var selectedGasCar: Car? = nil
    var selectedElectricityPriceDetail: ElectricityPriceDetail? = nil
    
    let gasCars: Variable<[Car]> = Variable([])
    let electricCars: Variable<[Car]> = Variable([])
    let electricityPricesDetail: Variable<[ElectricityPriceDetail]> = Variable([])
    let adapters = Adapters()
    private(set) var output = Output()
    
    
    
    override init() {
        super.init()
        self.loadAllCars()
        self.loadElectricityPrice()
    }
    
    private func loadAllCars() {
        
        apollo.fetch(query: AllCarsQuery()) { result, error in
            guard let allCars = result?.data?.allCars else { return }
            self.gasCars.value = allCars.filter({ $0.type == CarType.gas })
            self.electricCars.value = allCars.filter({ $0.type == CarType.electric })
            
            if let firstElectricCar = self.electricCars.value.first {
                self.selectedElectricCar = firstElectricCar
                self.output.electricCarText.value = firstElectricCar.description
            }
            
            if let firstGasCar = self.electricCars.value.first {
                self.selectedGasCar = firstGasCar
                self.output.gasCarText.value = firstGasCar.description
            }
        }
    }
    
    private func loadElectricityPrice() {
        apollo.fetch(query: AllElectricityProviderQuery()) { result, error in
            guard let electricityProvider = result?.data?.allElectricityProviders.first,
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
        self.input.electricCar.subscribe(onNext: { (cars) in
            guard let car = cars.first else {
                return
            }
            self.selectedElectricCar = car
            self.output.electricCarText.value = car.description
        }).disposed(by: disposeBag)
        self.input.gasCar.subscribe(onNext: { cars in
            guard let car = cars.first else {
                return
            }
            self.selectedGasCar = car
            self.output.gasCarText.value = car.description
        }).disposed(by: disposeBag)
        self.input.electricityPriceDetail.subscribe(onNext: { electricityPricesDetail in
            guard let electricityPriceDetail = electricityPricesDetail.first else {
                return
            }
            self.selectedElectricityPriceDetail = electricityPriceDetail
            self.output.electricityPriceText.value = electricityPriceDetail.description
        }).disposed(by: disposeBag)
        
        return self.output
    }

}
