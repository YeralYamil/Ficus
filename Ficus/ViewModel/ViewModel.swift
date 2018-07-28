//
//  ViewModel.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/28/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output?
}
