//
//  NewsRouter.swift
//  Ficus
//
//  Created by Yeral Yamil on 8/6/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import UIKit

struct NewsRouter: Router {
    
    func route<T>(to: Route, fromViewController: UIViewController, viewModel: T?) {
        guard let newsViewModel = viewModel as? NewsCellViewModel else {
            return
        }
        
        guard let newsViewController = R.storyboard.news.newsDetailsViewController() else {
            return
        }
        
        newsViewController.newsViewModel = newsViewModel
        fromViewController.show(newsViewController, sender: nil)
        
    }
}
