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
        var selectedElectricCar: Car? = nil
        var selectedGasCar: Car? = nil
        var selectedElectricityPriceDetail: ElectricityPriceDetail? = nil
    }
    
    //Move to a service class
    private let apollo = ApolloClient(url: URL(string: "https://api.graph.cool/simple/v1/cjj3nnfwq52jh0115681afinu")!)
    private var electricityProvider: ElectricityProvider?
    private var input: Input!
    private let disposeBag = DisposeBag()
    
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
        }
    }
    
    private func loadElectricityPrice() {
        apollo.fetch(query: AllElectricityProviderQuery()) { result, error in
            guard let electricityProvider = result?.data?.allElectricityProviders.first,
                  let electricityPricesDetail = electricityProvider.electricityPriceDetails else { return }
            self.electricityProvider = electricityProvider
            self.electricityPricesDetail.value = electricityPricesDetail
        }
    }
    
    func transform(input: Input) {
        self.input = input
        self.input.electricCar.subscribe(onNext: { cars in
            self.output.selectedElectricCar = cars.first
        }).disposed(by: disposeBag)
        self.input.gasCar.subscribe(onNext: { cars in
            self.output.selectedGasCar = cars.first
        }).disposed(by: disposeBag)
        self.input.electricityPriceDetail.subscribe(onNext: { electricityPricesDetail in
            self.output.selectedElectricityPriceDetail = electricityPricesDetail.first
        }).disposed(by: disposeBag)
    }

}
