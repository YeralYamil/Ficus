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
    private let router: Router = CarSelectionRouter()

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
            .bind(to: gasCarPickerView.rx.items(adapter: self.carSelectionViewModel.adapters.gasCar))
            .disposed(by: disposeBag)
        self.carSelectionViewModel.electricCars.asObservable()
            .bind(to: electricCarPickerView.rx.items(adapter: self.carSelectionViewModel.adapters.electricCar))
            .disposed(by: disposeBag)
        self.carSelectionViewModel.electricityPricesDetail.asObservable()
            .bind(to: priceOfElectricityPickerView.rx.items(adapter: self.carSelectionViewModel.adapters.electricityPriceDetail))
            .disposed(by: disposeBag)
        
        
        let _ = electricCarPickerView.rx.itemTitles(self.carSelectionViewModel.gasCars.asObservable())
        
        let input = CarSelectionViewModel.Input(electricCar: electricCarPickerView.rx.modelSelected(Car.self).asObservable(), gasCar: gasCarPickerView.rx.modelSelected(Car.self).asObservable(), electricityPriceDetail: priceOfElectricityPickerView.rx.modelSelected(ElectricityPriceDetail.self).asObservable())
        self.carSelectionViewModel.transform(input: input)
    }
    
    @IBAction func calculateTap(_ sender: UIBarButtonItem) {
        router.route(to: .calculator, fromViewController: self, viewModel: self.carSelectionViewModel)
    }

}
