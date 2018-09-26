//
//  ViewControllerExtension.swift
//  Ficus
//
//  Created by Yeral Yamil on 9/6/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNavigationTitleImage(image: UIImage?) {
        guard let image = image else { return }
        navigationItem.leftBarButtonItem?.customView = UIImageView(image: image)
        navigationItem.titleView = UIImageView(image: image)
    }
    
    func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
