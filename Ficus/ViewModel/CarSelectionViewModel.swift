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
    
    private let graphQLEndpoint = "https://api.graph.cool/simple/v1/cjj3nnfwq52jh0115681afinu";
    let allCars: Variable<[AllCarsQuery.Data.AllCar]> = Variable([])
    let pickerViewAdapter = RxPickerViewStringAdapter<[AllCarsQuery.Data.AllCar]>(components: [],
                                                                                  numberOfComponents: { _,_,_  in 1 },
                                                                                  numberOfRowsInComponent: { (datasource: RxPickerViewDataSource<[AllCarsQuery.Data.AllCar]>, pickerView: UIPickerView, items: [AllCarsQuery.Data.AllCar], row: Int) -> Int in
                                                                                    return items.count
    },
                                                                                  titleForRow: { (_, _, items: [AllCarsQuery.Data.AllCar], row, _) -> String? in
                                                                                    return items[row].carCategory.name
    })
    
    
    override init() {
        super.init()
        self.loadAllCars()
    }
    
    private func loadAllCars() {
        let apollo = ApolloClient(url: URL(string: graphQLEndpoint)!)
        
        apollo.fetch(query: AllCarsQuery()) { result, error in
            guard let allCars = result?.data?.allCars else { return }
            self.allCars.value = allCars
        }
    }

}
