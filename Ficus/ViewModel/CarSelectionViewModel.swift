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
    
    //Move to a service class
    private let apollo = ApolloClient(url: URL(string: "https://api.graph.cool/simple/v1/cjj3nnfwq52jh0115681afinu")!)
    private var electricityProvider: ElectricityProvider?
    
    let gasCars: Variable<[Car]> = Variable([])
    let electricCars: Variable<[Car]> = Variable([])
    let electricityPricesDetail: Variable<[ElectricityPriceDetail]> = Variable([])
    
    
    let electricityPricePickerViewAdapter = RxPickerViewStringAdapter<[ElectricityPriceDetail]>(components: [],
                                                                                  numberOfComponents: { _,_,_  in 1 },
                                                                                  numberOfRowsInComponent: { (datasource: RxPickerViewDataSource<[ElectricityPriceDetail]>, pickerView: UIPickerView, items: [ElectricityPriceDetail], row: Int) -> Int in
                                                                                    return items.count
    },
                                                                                  titleForRow: { (_, _, items: [ElectricityPriceDetail], row, _) -> String? in
                                                                                    return "\(items[row].type) - \(items[row].price)"
    })
    
    
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
            print("Electric cars: \(self.electricCars.value)")
            print("Gas cars: \(self.gasCars.value)")
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
    
    func createCarPickerAdapter() -> RxPickerViewStringAdapter<[Car]>{
        let carPickerAdapter = RxPickerViewStringAdapter<[Car]>(components: [],
                                         numberOfComponents: { _,_,_  in 1 },
                                         numberOfRowsInComponent: { (datasource: RxPickerViewDataSource<[Car]>, pickerView: UIPickerView, items: [Car], row: Int) -> Int in
                                            return items.count
        },
                                         titleForRow: { (_, _, items: [Car], row, _) -> String? in
                                            return "\(items[row].carCategory.name) - \(items[row].comparisonText)"
        })
        return carPickerAdapter
    }

}
