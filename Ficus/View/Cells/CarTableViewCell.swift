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
    
    func configure(viewModel: CarCellViewModelProtocol) {
        bindViews(viewModel: viewModel)
        if (viewModel.carType == .gas) {
            carImageView.image = R.image.gas_car()
            titleLabel.text = R.string.localizable.gasVehicle()
            efficiencyLabel.text = R.string.localizable.litersPer100km()
            priceLabel.text = R.string.localizable.priceOfGas()
        }
    }
    
    func bindViews(viewModel: CarCellViewModelProtocol) {
        priceTextField.text = viewModel.price
        efficiencyTextField.text = viewModel.efficiency
        
        let input = CarCellViewModel.Input(price: priceTextField.rx.text.orEmpty.asObservable(), efficiency: efficiencyTextField.rx.text.orEmpty.asObservable())
        
        if let output = viewModel.transform(input: input) {
            output.formattedCost.bind(to: costLabel.rx.text).disposed(by: disposeBag)
        }
    }
    
}
