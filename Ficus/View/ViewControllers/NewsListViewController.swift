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
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var newsListViewModel = NewsListViewModel()
    private let disposeBag = DisposeBag()
    private let router = NewsRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViews()
        setUpPageControl()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.allowsSelection = true
        
        collectionView.rx
            .modelSelected(NewsCellViewModel.self)
            .subscribe({ [unowned self] (event) in
                guard let viewModel = event.event.element else { return }
                self.router.route(to: .newsDetail, fromViewController: self, viewModel: viewModel)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpPageControl() {
        collectionView.rx.didScroll
            .map { [unowned self] (Void) -> Int in
                let currentPage = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
                return Int(currentPage)
            }
            .bind(to: self.pageControl.rx.currentPage)
            .disposed(by: disposeBag)
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
        output.numberOfItems
            .bind(to: self.pageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension NewsListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = min(view.frame.width, view.frame.height)
        let height = view.frame.width < view.frame.height ? collectionView.frame.height : collectionView.frame.height * 0.8
        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
