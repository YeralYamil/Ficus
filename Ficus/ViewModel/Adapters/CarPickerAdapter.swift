//
//  CarPickerAdapter.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct CarPickerAdapter {
    static func create() -> RxPickerViewStringAdapter<[Car]>{
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
