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
    
    func route<T: ViewModel>(to: Route, fromViewController: UIViewController, viewModel: T?) {
        guard let carSelectionViewModel = viewModel as? CarSelectionViewModel else {
            return
        }
        
        guard let calculatorViewController = R.storyboard.calculator.calculatorViewController() else {
            return
        }
        
        calculatorViewController.calculatorViewModel = CalculatorViewModel(electricCar: carSelectionViewModel.selectedElectricCar!, gasCar: carSelectionViewModel.selectedGasCar!, electricityPriceDetail: carSelectionViewModel.selectedElectricityPriceDetail!)
        fromViewController.show(calculatorViewController, sender: nil)
        
    }
}
