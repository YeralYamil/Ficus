//
//  Service.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/19/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation

protocol Service {
    func loadCars(completion: @escaping ([Car]?, Error?) -> Void)
    func loadElectrivityProvider(completion: @escaping (ElectricityProvider?, Error?) -> Void)
    func loadNews(completion: @escaping ([News]?, Error?) -> Void)
}
