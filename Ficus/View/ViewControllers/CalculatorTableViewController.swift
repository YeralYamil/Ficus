//
//  CalculatorViewController.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift

class CalculatorTableViewController: UITableViewController {
    
    private let carCellIdentifier = "CarCell"
    private let disposeBag = DisposeBag()
    
    var calculatorViewModel: CalculatorViewModel!

    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var savingsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    private func configureTableView() {
        let data = Observable<[CarCellViewModel]>.just([calculatorViewModel.electricCarCellViewModel, calculatorViewModel.gasCarCellViewModel])
        
        data.bind(to: tableView.rx.items(cellIdentifier: carCellIdentifier)) { index, viewModel, cell in
            if let carCell = cell as? CarTableViewCell {
                carCell.configure(viewModel: viewModel)
            }
        }.disposed(by: disposeBag)
    }
    
    private func configureLabels() {
        let input = CalculatorViewModel.Input(distance: distanceTextField.rx.text.asObservable())
        
        let output = calculatorViewModel.transform(input: input)
        
        output.savings.bind(to: savingsLabel.rx.text).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
