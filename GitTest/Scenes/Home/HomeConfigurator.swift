//
//  HomeConfigurator.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import UIKit

extension HomeController: HomePresenterOutput{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue, sender: sender)
    }
    
}

extension HomeInteractor: HomeControllerOutput{
    
}

extension HomePresenter: HomeInteractorOutput{
    
}

class HomeConfigurator {
    
    static let sharedInstance = HomeConfigurator()
    
    private init(){}
    
    func configure(viewController: HomeController){
        
        let router = HomeRouter()
        router.viewController = viewController
        
        let presenter = HomePresenter()
        presenter.output = viewController
        
        let interactor = HomeInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
        
    }
    
}
