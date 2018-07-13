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
    
    @IBOutlet private weak var gasCarPickerView: UIPickerView!
    @IBOutlet private weak var electricCarPickerView: UIPickerView!
    @IBOutlet private weak var priceOfElectricityPickerView: UIPickerView!
    
    @IBOutlet weak var calculateBarButtonItem: UIBarButtonItem!
    private let carSelectionViewModel = CarSelectionViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupPickerViews()
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
    
    func setupPickerViews() {
        self.carSelectionViewModel.gasCars.asObservable()
            .bind(to: gasCarPickerView.rx.items(adapter: self.carSelectionViewModel.createCarPickerAdapter()))
            .disposed(by: disposeBag)
        self.carSelectionViewModel.electricCars.asObservable()
            .bind(to: electricCarPickerView.rx.items(adapter: self.carSelectionViewModel.createCarPickerAdapter()))
            .disposed(by: disposeBag)
        self.carSelectionViewModel.electricityPricesDetail.asObservable()
            .bind(to: priceOfElectricityPickerView.rx.items(adapter: self.carSelectionViewModel.electricityPricePickerViewAdapter))
            .disposed(by: disposeBag)
    }

}
