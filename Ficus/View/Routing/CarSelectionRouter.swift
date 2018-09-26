//
//  CarSelectionRouter.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import UIKit

struct CarSelectionRouter: Router {
    
    func route<T>(to: Route, fromViewController: UIViewController, viewModel: T?) {
        guard let carSelectionViewModel = viewModel as? CarSelectionViewModel else {
            return
        }
        
        guard let calculatorViewController = R.storyboard.calculator.calculatorViewController() else {
            return
        }
        
        guard let selectedElectricCar = carSelectionViewModel.selectedElectricCar,
            let selectedGasCar = carSelectionViewModel.selectedGasCar,
            let electricityPriceDetail = carSelectionViewModel.selectedElectricityPriceDetail else { return }
        
        calculatorViewController.calculatorViewModel = CalculatorViewModel(electricCar: selectedElectricCar, gasCar: selectedGasCar, electricityPriceDetail: electricityPriceDetail)
        fromViewController.show(calculatorViewController, sender: nil)
        
    }
}
