//
//  HomeRouter.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterInput {
    func showAnotherVC(navigation: UINavigationController, source: UIViewController, sender: Any?)
}

class HomeRouter: HomeRouterInput{
    
    weak var viewController: HomeController!
    
    func showAnotherVC(navigation: UINavigationController, source: UIViewController, sender: Any?) {
        
        let pullRequest = PullRequestController()
        let segue = UIStoryboardSegue(identifier: "pullRequest", source: source, destination: pullRequest)
        passDataToNextScene(segue: segue, sender: sender)
        navigation.pushViewController(pullRequest, animated: true)
        
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "pullRequest" {
            
            let destination = segue.destination as! PullRequestController
            if let send = sender as? Repository{
                
                destination.author = send.authorName
                destination.repository = send.repositoryName
                
            }
            
        }
        
    }
    
}
