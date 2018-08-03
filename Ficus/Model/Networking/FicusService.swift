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
        apollo.fetch(query: AllCarsQuery()) { result, error in
            if let error = error {
                completion(nil, error)
            }
            guard let allCars = result?.data?.allCars else {
                completion(nil, ServiceError.custom("No data found"))
                return
            }
            
            completion(allCars, nil)
        }
    }
    
    func loadElectrivityProvider(completion: @escaping (ElectricityProvider?, Error?) -> Void) {
        apollo.fetch(query: AllElectricityProviderQuery()) { result, error in
            if let error = error {
                completion(nil, error)
            }
            guard let electricityProvider = result?.data?.allElectricityProviders.first else {
                completion(nil, ServiceError.custom("No data found"))
                return
            }
            
            completion(electricityProvider, nil)
        }
    }
    
    func loadNews(completion: @escaping ([News]?, Error?) -> Void) {
        apollo.fetch(query: AllNewsQuery()) { result, error in
            if let error = error {
                completion(nil, error)
            }
            guard let allNews = result?.data?.allNews else {
                completion(nil, ServiceError.custom("No data found"))
                return
            }
            
            completion(allNews, nil)
        }
    }
    
}
