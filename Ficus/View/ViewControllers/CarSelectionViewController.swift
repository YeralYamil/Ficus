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

class CarSelectionViewController: UIViewController {
    
    private var gasCarPickerView = UIPickerView()
    private var electricCarPickerView = UIPickerView()
    private var electricityPricePickerView = UIPickerView()
    
    @IBOutlet weak var electricCarTextField: UITextField!
    @IBOutlet weak var gasCarTextField: UITextField!
    @IBOutlet weak var electricityPriceTextField: UITextField!
    
    @IBOutlet weak var calculateBarButtonItem: UIBarButtonItem!
    private let carSelectionViewModel: CarSelectionViewModelProtocol = CarSelectionViewModel()
    private let disposeBag = DisposeBag()
    private let router: Router = CarSelectionRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldsInputView()
        bindViews()
        addTapGestureRecognizer()
        setNavigationTitleImage(image: R.image.logo_header())
        setNavigationBarTransparent()
    }
    
    private func addTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTextFieldsInputView() {
        electricCarTextField.inputView = electricCarPickerView
        gasCarTextField.inputView = gasCarPickerView
        electricityPriceTextField.inputView = electricityPricePickerView
    }
    
    func bindViews() {

        //Move this to the output to keep consistency
        carSelectionViewModel.electricCars.asObservable()
            .bind(to: electricCarPickerView.rx.itemTitles) { $1.description }
            .disposed(by: disposeBag)
        carSelectionViewModel.gasCars.asObservable()
            .bind(to: gasCarPickerView.rx.itemTitles) { $1.description }
            .disposed(by: disposeBag)
        carSelectionViewModel.electricityPricesDetail.asObservable()
            .bind(to: electricityPricePickerView.rx.itemTitles) { $1.description }
            .disposed(by: disposeBag)
        
        let input = CarSelectionViewModel.Input(electricCar: electricCarPickerView.rx.modelSelected(Car.self).asObservable(), gasCar: gasCarPickerView.rx.modelSelected(Car.self).asObservable(), electricityPriceDetail: electricityPricePickerView.rx.modelSelected(ElectricityPriceDetail.self).asObservable())
        
        if let output = self.carSelectionViewModel.transform(input: input) {
            output.electricCarText
                .asObservable()
                .bind(to: electricCarTextField.rx.text)
                .disposed(by: disposeBag)
            output.gasCarText
                .asObservable()
                .bind(to: gasCarTextField.rx.text)
                .disposed(by: disposeBag)
            output.electricityPriceText
                .asObservable()
                .bind(to: electricityPriceTextField.rx.text)
                .disposed(by: disposeBag)
        }
        
    }
    
    @IBAction func calculateTap(_ sender: UIBarButtonItem) {
        router.route(to: .calculator, fromViewController: self, viewModel: self.carSelectionViewModel)
    }

}
