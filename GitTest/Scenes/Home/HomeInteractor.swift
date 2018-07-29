//
//  HomeInteractor.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

protocol HomeInteractorInput {
    func fetchItems(request: HomeModels.Fetch.Request)
}

protocol HomeInteractorOutput {
    func presentFetchResults(response: HomeModels.Fetch.Response)
}

class HomeInteractor: HomeInteractorInput{
    
    var output: HomeInteractorOutput!
    var worker: HomeWorker!
    
    func fetchItems(request: HomeModels.Fetch.Request) {
        
        worker = HomeWorker()
        
        worker.fetchRepositories(url: request.url, success: { (data) in
            self.output.presentFetchResults(response: HomeModels.Fetch.Response(isError: data.isError, message: data.message, repositories: data.repositories))
        }) { (data) in
            self.output.presentFetchResults(response: HomeModels.Fetch.Response(isError: data.isError, message: data.message, repositories: data.repositories))
        }
        
    }
    
}
