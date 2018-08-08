//
//  NewsDetailsViewController.swift
//  Ficus
//
//  Created by Yeral Yamil on 8/6/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    var newsViewModel: NewsCellViewModel!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: newsViewModel.articleUrlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
