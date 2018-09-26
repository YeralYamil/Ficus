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
    
    private let disposeBag = DisposeBag()
    
    var calculatorViewModel: CalculatorViewModelProtocol!

    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView(carViewModels: calculatorViewModel.carCellViewModelsObservable)
        setNavigationTitleImage(image: R.image.logo_header())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViews()
    }
    
    private func configureTableView(carViewModels: Observable<[CarCellViewModelProtocol]>) {
        
        carViewModels
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.carCell.identifier)) { index, viewModel, cell in
                if let carCell = cell as? CarTableViewCell {
                    carCell.configure(viewModel: viewModel)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindViews() {
        
        let input = CalculatorViewModel.Input(distance: distanceTextField.rx.text.orEmpty.asObservable())
        guard let output = calculatorViewModel.transform(input: input) else { return }
        Observable.combineLatest(output.savings, output.kgCO2Savings)
            .map { self.getSavingsAttributedString(savings: $0, kgCO2Savings: $1) }
            .bind(to: savingsLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
    }
    
    private func getSavingsAttributedString(savings: Double, kgCO2Savings: Double) -> NSAttributedString? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let savingsString = currencyFormatter.string(from: NSNumber(value: savings)),
              let kgCO2SavingsString = numberFormatter.string(from: NSNumber(value: kgCO2Savings)),
              let standoutColor = R.color.standoutText() else { return nil }
        
        let firstAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: standoutColor,
                                                             .font: UIFont.boldSystemFont(ofSize: 22)]
        let secondAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: standoutColor,
                                                              .font: UIFont.systemFont(ofSize: 20)]
        
        let firstString = NSMutableAttributedString(string: String(format: R.string.localizable.savedAndUpToKgOfCO2(savingsString, kgCO2SavingsString)), attributes: firstAttributes)
        let secondString = NSAttributedString(string: R.string.localizable.keptAwayFromTheAirPerYearDrivingElectric(), attributes: secondAttributes)
        firstString.append(secondString)
        
        return NSAttributedString(attributedString: firstString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
