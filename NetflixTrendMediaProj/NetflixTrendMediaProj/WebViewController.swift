//
//  WebViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/18.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {
    
    var webView: WKWebView!
    var myLink : String?
    var pageTitle: String?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let myURL = URL(string: myLink ?? "https://www.apple.com")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
        
        titleLabel.text = pageTitle!
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }

//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    
    
    
    
}
