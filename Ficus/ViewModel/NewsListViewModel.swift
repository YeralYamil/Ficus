//
//  NewsListViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/31/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

protocol NewsListViewModelProtocol {
    func transform() -> NewsListViewModel.Output
}

class NewsListViewModel: NewsListViewModelProtocol {
    
    private let service: Service
    private var newsList = Variable<[News]>([])
    private var numberOfItems = Variable<Int>(0)
    
    init (service: Service = FicusService()) {
        self.service = service
        loadAllNews()
    }
    
    private func loadAllNews() {
        service.loadNews { [weak self] (news, error) in
            if let error = error { print(error) }
            if self == nil { return }
            guard let newsList = news else { return }
            self?.newsList.value = newsList
        }
    }
    
    func transform() -> NewsListViewModel.Output {
        let newsCellViewModelList = newsList
            .asObservable()
            .map { (newsList) -> [NewsCellViewModel] in
                return newsList.map({ (news) -> NewsCellViewModel in
                    return NewsCellViewModel(news: news)
                })
            }
        
        let numberOfItems = newsList.asObservable().reduce(0, accumulator: { _,_ in 1 })
        
        let output = Output(newsCellViewModels: newsCellViewModelList, numberOfItems: numberOfItems)
        return output
    }
}


extension NewsListViewModel {
    struct Output {
        let newsCellViewModels: Observable<[NewsCellViewModel]>
        let numberOfItems: Observable<Int>
    }
}
