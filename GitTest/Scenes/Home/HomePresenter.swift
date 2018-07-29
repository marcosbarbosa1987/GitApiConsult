//
//  HomePresenter.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

protocol HomePresenterInput {
    func presentFetchResults(response: HomeModels.Fetch.Response)
}

protocol HomePresenterOutput {
    func successFetchedItems(viewModel: HomeModels.Fetch.ViewModel)
    func errorFetchingItems(viewModel: HomeModels.Fetch.ViewModel)
}

class HomePresenter: HomePresenterInput {
    
    var output: HomePresenterOutput!
    
    func presentFetchResults(response: HomeModels.Fetch.Response) {
        
        let viewModel = HomeModels.Fetch.ViewModel(isError: response.isError, message: response.message, repositories: response.repositories)
        
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
