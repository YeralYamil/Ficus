//
//  NewsCellViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/31/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsCellViewModelProtocol {
    func transform() -> NewsCellViewModel.Output
    var articleUrlString: String { get }
}

struct NewsCellViewModel: NewsCellViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private let news: News
    private let dataRequesting: DataRequesting
    
    var articleUrlString: String {
        get {
            return news.url
        }
    }
    
    init(news: News, dataRequesting: DataRequesting = URLSession.shared.rx) {
        self.news = news
        self.dataRequesting = dataRequesting
    }
    
    func transform() -> NewsCellViewModel.Output {
        
        let descriptionObservable = Observable.just(news.description)
        let titleObservable = Observable.just(news.title)
        
        let imageUrlRequest = URLRequest(url: URL(string: news.imageUrl)!)
        let imageObservable = dataRequesting
            .response(request: imageUrlRequest)
            .map( { $1 } )
        
        let output = Output(imageUrl: imageObservable,
                            title: titleObservable,
                            description: descriptionObservable)
        
        return output
    }
}

extension NewsCellViewModel {
    
    struct Output {
        let imageUrl: Observable<Data>
        let title: Observable<String>
        let description: Observable<String>
    }
}
