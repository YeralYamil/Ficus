//
//  DataRequesting.swift
//  Ficus
//
//  Created by Yeral Yamil on 9/22/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import RxSwift

protocol DataRequesting {
    func response(request: URLRequest) -> RxSwift.Observable<(response: HTTPURLResponse, data: Data)>
}

extension Reactive: DataRequesting where Base : URLSession {
    
}
