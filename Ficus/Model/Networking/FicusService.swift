//
//  FicusService.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/19/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import Apollo

class FicusService: Service {
    
    private let apollo = ApolloClient(url: URL(string: "https://api.graph.cool/simple/v1/cjj3nnfwq52jh0115681afinu")!)
    
    func loadCars(completion: @escaping ([Car]?, Error?) -> Void) {
        apollo.fetch (query: AllCarsQuery()) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let graphQLResult):
                completion(graphQLResult.data?.allCars, nil)
                return
            }
        }
    }
    
    func loadElectrivityProvider(completion: @escaping (ElectricityProvider?, Error?) -> Void) {
        apollo.fetch(query: AllElectricityProviderQuery()) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let graphQLResult):
                completion(graphQLResult.data?.allElectricityProviders.first, nil)
                return
            }
        }
    }
    
    func loadNews(completion: @escaping ([News]?, Error?) -> Void) {
        apollo.fetch(query: AllNewsQuery()) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let graphQLResult):
                completion(graphQLResult.data?.allNews, nil)
                return
            }
        }
    }
    
}
