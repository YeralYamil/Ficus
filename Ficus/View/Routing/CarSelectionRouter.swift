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
    
    let calculatorStoryBoardString = "Calculator"
    let calculatorTableViewControllerString = "CalculatorTableViewController"
    
    func route(to: Route, fromViewController: UIViewController, viewModel: NSObject?) {
        guard let carSelectionViewModel = viewModel as? CarSelectionViewModel else {
            return
        }
        guard let calculatorViewController = UIStoryboard(name: calculatorStoryBoardString, bundle: nil).instantiateViewController(withIdentifier: calculatorTableViewControllerString) as? CalculatorTableViewController else {
            return
        }
        
        calculatorViewController.calculatorViewModel = CalculatorViewModel(electricCar: carSelectionViewModel.output.selectedElectricCar!, gasCar: carSelectionViewModel.output.selectedGasCar!, electricityPriceDetail: carSelectionViewModel.output.selectedElectricityPriceDetail!)
        fromViewController.show(calculatorViewController, sender: nil)
        
    }
}
