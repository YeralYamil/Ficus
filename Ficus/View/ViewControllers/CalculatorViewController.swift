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
    
    var calculatorViewModel: CalculatorViewModel!

    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView(carViewModels: calculatorViewModel.carCellViewModelsObservable)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViews()
    }
    
    private func configureTableView(carViewModels: Observable<[CarCellViewModel]>) {
        
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
        output.savings
            .map { self.getSavingsAttributedString(savings: $0) }
            .bind(to: savingsLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
    }
    
    private func getSavingsAttributedString(savings: Double) -> NSAttributedString? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        guard let savingsString = formatter.string(from: NSNumber(value: savings)),
              let mainColor = R.color.main() else { return nil }
        
        let firstAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: mainColor,
                                                             .font: UIFont.boldSystemFont(ofSize: 22)]
        let secondAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: mainColor,
                                                              .font: UIFont.systemFont(ofSize: 20)]
        
        let firstString = NSMutableAttributedString(string: String(format: R.string.localizable.saveD(savingsString)), attributes: firstAttributes)
        let secondString = NSAttributedString(string: R.string.localizable.perYearDrivingElectric(), attributes: secondAttributes)
        firstString.append(secondString)
        
        return NSAttributedString(attributedString: firstString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
