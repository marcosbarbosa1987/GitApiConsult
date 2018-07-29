//
//  PullRequestInteractor.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

protocol PullRequestInteractorInput {
    func fetchItems(request: PullRequestModels.Fetch.Request)
}

protocol PullRequestInteractorOutput {
    func presentFetchResults(response: PullRequestModels.Fetch.Response)
}

class PullRequestInteractor: PullRequestInteractorInput{
    
    var output: PullRequestInteractorOutput!
    var worker: PullRequestWorker!
    
    func fetchItems(request: PullRequestModels.Fetch.Request) {
        worker = PullRequestWorker()
        
        worker.fetchPellRequest(url: request.url, success: { (data) in
            self.output.presentFetchResults(response: PullRequestModels.Fetch.Response(isError: data.isError, message: data.message, pulls: data.pulls))
        }) { (data) in
            self.output.presentFetchResults(response: PullRequestModels.Fetch.Response(isError: data.isError, message: data.message, pulls: data.pulls))
        }
    }
    
}
