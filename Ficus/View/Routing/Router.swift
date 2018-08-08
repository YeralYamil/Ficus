//
//  Router.swift
//  Ficus
//
//  Created by Yeral Yamil on 7/15/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    func route<T: ViewModel>(to: Route, fromViewController: UIViewController, viewModel: T?)
}

enum Route {
    case calculator
    case newsDetail
}
