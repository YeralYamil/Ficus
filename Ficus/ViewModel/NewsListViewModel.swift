//
//  NewsListViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/31/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

class NewsListViewModel: ViewModel {
    
    struct Input { }
    struct Output {
        let newsCellViewModels: Observable<[NewsCellViewModel]>
    }
    
    private let service: Service
    private var newsList = Variable<[News]>([])
    
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
    
    func transform(input: NewsListViewModel.Input = Input()) -> NewsListViewModel.Output? {
        let newsCellViewModelList = newsList
            .asObservable()
            .map { (newsList) -> [NewsCellViewModel] in
                return newsList.map({ (news) -> NewsCellViewModel in
                    return NewsCellViewModel(news: news)
                })
            }
        
        let output = Output(newsCellViewModels: newsCellViewModelList)
        return output
    }
}
