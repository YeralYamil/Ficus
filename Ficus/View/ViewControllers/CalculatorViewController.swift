//
//  CalculatorViewController.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift

class CalculatorViewController: UIViewController {
    
    private let carCellIdentifier = "CarCell"
    private let disposeBag = DisposeBag()
    
    var calculatorViewModel: CalculatorViewModel?

    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViews()
    }
    
    private func configureTableView() {
        guard let calculatorViewModel = self.calculatorViewModel else {
            print("Calculator view model should not be nil")
            return
        }
        let data = Observable<[CarCellViewModel]>.just([calculatorViewModel.electricCarCellViewModel, calculatorViewModel.gasCarCellViewModel])
        
        data
            .bind(to: tableView.rx.items(cellIdentifier: carCellIdentifier)) { index, viewModel, cell in
                if let carCell = cell as? CarTableViewCell {
                    carCell.configure(viewModel: viewModel)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindViews() {
        guard let calculatorViewModel = self.calculatorViewModel else {
            print("Calculator view model should not be nil")
            return
        }
        
        let input = CalculatorViewModel.Input(distance: distanceTextField.rx.text.asObservable())
        let output = calculatorViewModel.transform(input: input)
        
        output.savings
            .map { self.getSavingsAttributedString(savings: $0) }
            .bind(to: savingsLabel.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    private func getSavingsAttributedString(savings: Double) -> NSAttributedString? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        guard let savingsString = formatter.string(from: NSNumber(value: savings)) else { return nil }
        
        let firstAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.blue,
                                                             .font: UIFont.boldSystemFont(ofSize: 22)]
        let secondAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.blue,
                                                              .font: UIFont.systemFont(ofSize: 20)]
        
        let firstString = NSMutableAttributedString(string: String(format: NSLocalizedString("%@ SAVED ", comment: "Money saved driving electric format"), savingsString), attributes: firstAttributes)
        let secondString = NSAttributedString(string: NSLocalizedString("per year driving electric!", comment: "Money saved driving electric second part of the label"), attributes: secondAttributes)
        
        firstString.append(secondString)
        
        return NSAttributedString(attributedString: firstString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
