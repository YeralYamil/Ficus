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
    
    private var gasCarPickerView = UIPickerView()
    private var electricCarPickerView = UIPickerView()
    private var priceOfElectricityPickerView = UIPickerView()
    
    @IBOutlet weak var electricCarTextField: UITextField!
    @IBOutlet weak var gasCarTextField: UITextField!
    @IBOutlet weak var electricityPriceTextField: UITextField!
    
    @IBOutlet weak var calculateBarButtonItem: UIBarButtonItem!
    private let carSelectionViewModel = CarSelectionViewModel()
    private let disposeBag = DisposeBag()
    private let router: Router = CarSelectionRouter()
    
    /*override init() {
        super.init()
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldsInputView()
        bindViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTextFieldsInputView() {
        electricCarTextField.inputView = electricCarPickerView
        gasCarTextField.inputView = gasCarPickerView
        electricCarTextField.inputView = electricCarPickerView
    }
    
    func bindViews() {

        carSelectionViewModel.electricCars.asObservable()
            .bind(to: electricCarPickerView.rx.itemTitles) { _, car in
                return car.description
            }
            .disposed(by: disposeBag)
        carSelectionViewModel.gasCars.asObservable()
            .bind(to: gasCarPickerView.rx.itemTitles) { _, car in
                return car.description
            }
            .disposed(by: disposeBag)
        carSelectionViewModel.electricityPricesDetail.asObservable()
            .bind(to: priceOfElectricityPickerView.rx.itemTitles) { _, electricityPriceDetail in
                return electricityPriceDetail.description
            }
            .disposed(by: disposeBag)
        
        let _ = electricCarPickerView.rx.itemTitles(self.carSelectionViewModel.gasCars.asObservable())
        
        let input = CarSelectionViewModel.Input(electricCar: electricCarPickerView.rx.modelSelected(Car.self).asObservable(), gasCar: gasCarPickerView.rx.modelSelected(Car.self).asObservable(), electricityPriceDetail: priceOfElectricityPickerView.rx.modelSelected(ElectricityPriceDetail.self).asObservable())
        let output = self.carSelectionViewModel.transform(input: input)
        
        output.electricCarText.asObservable().bind(to: electricCarTextField.rx.text).disposed(by: disposeBag)
        output.gasCarText.asObservable().bind(to: gasCarTextField.rx.text).disposed(by: disposeBag)
        output.electricityPriceText.asObservable().bind(to: electricityPriceTextField.rx.text).disposed(by: disposeBag)
        
    }
    
    @IBAction func calculateTap(_ sender: UIBarButtonItem) {
        router.route(to: .calculator, fromViewController: self, viewModel: self.carSelectionViewModel)
    }

}
