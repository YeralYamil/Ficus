//
//  CarTableViewCell.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/17/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var efficiencyTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    private var carCellViewModel: CarCellViewModel!
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: CarCellViewModel) {
        self.carCellViewModel = viewModel
        let input = CarCellViewModel.Input(price: priceTextField.rx.text.asObservable(), efficiency: efficiencyTextField.rx.text.asObservable())
        
        let output = carCellViewModel.transform(input: input)
        output.formattedPrice.bind(to: priceTextField.rx.text).disposed(by: disposeBag)
        output.formattedEfficiency.bind(to: efficiencyTextField.rx.text).disposed(by: disposeBag)
        output.formattedCost.bind(to: costLabel.rx.text).disposed(by: disposeBag)
        
        priceTextField.text = viewModel.price
        efficiencyTextField.text = viewModel.efficiency
    }
    

}
