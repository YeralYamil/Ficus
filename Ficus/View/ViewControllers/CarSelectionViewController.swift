//
//  CarSelectionViewController.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/9/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CarSelectionViewController: UIViewController {
    
    typealias Car = AllCarsQuery.Data.AllCar
    
    @IBOutlet private weak var gasCarPickerView: UIPickerView!
    
    @IBOutlet weak var electricCarPickerView: UIPickerView!
    
    private let carSelectionViewModel = CarSelectionViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.carSelectionViewModel.allCars.asObservable()
            .bind(to: gasCarPickerView.rx.items(adapter: self.carSelectionViewModel.pickerViewAdapter))
            .disposed(by: disposeBag)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class CarPickerViewAdapter: RxPickerViewStringAdapter<[AllCarsQuery.Data.AllCar]> {
    
    init() {
        super.init(components: [],
                   numberOfComponents: { _,_,_  in 1 },
                   numberOfRowsInComponent: { (datasource: RxPickerViewDataSource<[AllCarsQuery.Data.AllCar]>, pickerView: UIPickerView, items: [AllCarsQuery.Data.AllCar], row: Int) -> Int in
                    return items.count
        },
                   titleForRow: { (_, _, items: [AllCarsQuery.Data.AllCar], row, _) -> String? in
                    return items[row].carCategory.name
        })
    }
}
