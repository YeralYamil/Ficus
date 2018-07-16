//
//  ElectricityPriceDetailAdapter.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct ElectricityPriceDetailAdapter {
    static func create() -> RxPickerViewStringAdapter<[ElectricityPriceDetail]>{
        let adapter = RxPickerViewStringAdapter<[ElectricityPriceDetail]>(components: [],
                                                            numberOfComponents: { _,_,_  in 1 },
                                                            numberOfRowsInComponent: { (datasource: RxPickerViewDataSource<[ElectricityPriceDetail]>, pickerView: UIPickerView, items: [ElectricityPriceDetail], row: Int) -> Int in
                                                                return items.count
        },
                                                            titleForRow: { (_, _, items: [ElectricityPriceDetail], row, _) -> String? in
                                                                return "\(items[row].type) - \(items[row].price)"
        })

        return adapter
    }
}
