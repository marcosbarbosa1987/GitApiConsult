//
//  PullRequestPresenter.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

protocol PullRequestPresenterInput {
    func presentFetchResults(response: PullRequestModels.Fetch.Response)
}

protocol PullRequestPresenterOutput {
    func successFetchedItems(viewModel: PullRequestModels.Fetch.ViewModel)
    func errorFetchingItems(viewModel: PullRequestModels.Fetch.ViewModel)
}

class PullRequestPresenter: PullRequestPresenterInput {
    
    var output: PullRequestPresenterOutput!
    
    func presentFetchResults(response: PullRequestModels.Fetch.Response) {
        
        let viewModel = PullRequestModels.Fetch.ViewModel(isError: response.isError, message: response.message!, pulls: response.pulls!)
        
        if viewModel.isError{
            if let output = self.output{
                output.errorFetchingItems(viewModel: viewModel)
            }
        }else{
            if let output = self.output{
                output.successFetchedItems(viewModel: viewModel)
            }
        }
        
    }
    
}
