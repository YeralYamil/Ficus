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
    func route(to: Route, fromViewController: UIViewController, viewModel: NSObject?)
}

enum Route {
    case calculator
}
