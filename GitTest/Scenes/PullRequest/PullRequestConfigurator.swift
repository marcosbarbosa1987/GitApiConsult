//
//  PullRequestConfigurator.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import UIKit

extension PullRequestController: PullRequestPresenterOutput{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

extension PullRequestInteractor: PullRequestControllerOutput{
    
    
}

extension PullRequestPresenter: PullRequestInteractorOutput{
    
}

class PullRequestConfigurator{
    
    static let sharedInstance = PullRequestConfigurator()
    
    private init(){}
    
    func configure(viewController: PullRequestController){
        
        let router = PullRequestRouter()
        router.viewController = viewController
        
        let presenter = PullRequestPresenter()
        presenter.output = viewController
        
        let interactor = PullRequestInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
        
    }
    
}
