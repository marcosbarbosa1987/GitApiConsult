//
//  HomeWorker.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

typealias homeResponseHandler = (_ response: HomeModels.Fetch.Response) -> ()

class HomeWorker {
    
    
    let managerAPI = RestAPIManager()
    
    func fetchRepositories(url: String, success: @escaping(homeResponseHandler), fail: @escaping(homeResponseHandler)){
        
        
        managerAPI.fetchRepositories(from: url) { (validate, data) in
            
            if validate{
                success(HomeModels.Fetch.Response(isError: false, message: "Dados recuperados", repositories: data))
            }else{
                fail(HomeModels.Fetch.Response(isError: true, message: "Não recuperou dados", repositories: nil))
            }
            
        }
        
    }
    
}
