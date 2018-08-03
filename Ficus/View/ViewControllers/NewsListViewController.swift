//
//  NewsListViewController.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/31/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import RxSwift

class NewsListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var newsListViewModel = NewsListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViews()
    }
    
    private func bindViews() {
        guard let output = newsListViewModel.transform() else { return }
        
        output.newsCellViewModels
            .bind(to: collectionView.rx.items(cellIdentifier: R.reuseIdentifier.newsCollectionViewCell.identifier)) { index, viewModel, cell in
                if let newsCell = cell as? NewsCollectionViewCell {
                    newsCell.configure(viewModel: viewModel)
                }
            }
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
