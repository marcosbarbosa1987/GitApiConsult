//
//  PullRequestRouter.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import UIKit

protocol PullRequestRouterInput {
    func showAnotherView(navigation: UINavigationController, source: UIViewController, sender: Any?)
}

class PullRequestRouter: PullRequestRouterInput{
    
    weak var viewController: PullRequestController!
    
    func showAnotherView(navigation: UINavigationController, source: UIViewController, sender: Any?) {
        let webView = WebViewController()
        let segue = UIStoryboardSegue(identifier: "webView", source: source, destination: webView)
        passDataToNextScene(segue: segue, sender: sender)
        navigation.pushViewController(webView, animated: true)
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "webView"{
            
            let destination = segue.destination as! WebViewController
            if let pullRequest = sender as? PullRequest{
                
                destination.url = pullRequest.url
                
            }
            
        }
    }
    
}
