//
//  NewsCollectionViewCell.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/31/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    func configure(viewModel: NewsCellViewModel) {
        
        guard let output = viewModel.transform() else {
            return
        }
        
        output.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        output.description
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        output.imageUrl
            .map { UIImage(data: $0) }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
}
