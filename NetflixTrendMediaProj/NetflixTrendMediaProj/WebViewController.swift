//
//  WebViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/18.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var myLink : String?
    var pageTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: myLink!) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        titleLabel.text = pageTitle!
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
}
