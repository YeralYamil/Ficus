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
    
    private let gasCarImageName = "gas_car"

    @IBOutlet weak var efficiencyTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var efficiencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
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
        bindViews(viewModel: viewModel)
        if (viewModel.carType == .gas) {
            carImageView.image = UIImage(named: gasCarImageName)
            titleLabel.text = NSLocalizedString("Gas Vehicle", comment: "Title of the car cell")
            efficiencyLabel.text = NSLocalizedString("Liters per 100km", comment: "Gas car efficiency label")
            priceLabel.text = NSLocalizedString("Price of gas", comment: "Gas car price label")
        }
        
    }
    
    func bindViews(viewModel: CarCellViewModel) {
        priceTextField.text = viewModel.price
        efficiencyTextField.text = viewModel.efficiency
        
        let input = CarCellViewModel.Input(price: priceTextField.rx.text.asObservable(), efficiency: efficiencyTextField.rx.text.asObservable())
        
        let output = viewModel.transform(input: input)
        output.formattedCost.bind(to: costLabel.rx.text).disposed(by: disposeBag)
    }
    

}
