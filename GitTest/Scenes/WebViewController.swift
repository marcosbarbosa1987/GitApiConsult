//
//  WebViewController.swift
//  GitTest
//
//  Created by Marcos Barbosa on 28/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url: String?
    
    var webView: WKWebView = {
        var webView = WKWebView()
        webView.allowsLinkPreview = true
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(webView)
        
        if let urlRequest = url {
            
            let request = URLRequest(url: URL(string: urlRequest)!)
            webView.load(request)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
}
