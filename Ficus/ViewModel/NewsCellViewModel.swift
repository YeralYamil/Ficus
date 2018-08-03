//
//  NewsCellViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/31/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

class NewsCellViewModel: ViewModel {
    struct Input {}
    struct Output {
        let imageUrl: Observable<Data>
        let title: Observable<String>
        let description: Observable<String>
    }
    
    func transform(input: Input = Input()) -> NewsCellViewModel.Output? {
        
        let descriptionObservable = Observable.just(news.description)
        let titleObservable = Observable.just(news.title)
        
        let imageUrlRequest = URLRequest(url: URL(string: news.imageUrl)!)
        let imageObservable = URLSession.shared.rx
            .response(request: imageUrlRequest)
            .map( { $1 } )
        
        let output = Output(imageUrl: imageObservable,
                            title: titleObservable,
                            description: descriptionObservable)
        
        return output
    }
    
    private let news: News
    
    init(news: News) {
        self.news = news
    }
    
    
}
