//
//  PullRequestWorker.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

typealias pullRequestHandler = (_ response: PullRequestModels.Fetch.Response) -> ()

class PullRequestWorker{
    
    func fetchPellRequest(url: String, success: @escaping(pullRequestHandler), fail: @escaping(pullRequestHandler)){
        
        let managerAPIManager = RestAPIManager()
        
        managerAPIManager.fetchPullRequest(from: url) { (validate, data) in
            
            if validate{
                success(PullRequestModels.Fetch.Response(isError: false, message: "Dados recuperados", pulls: data))
            }else{
                fail(PullRequestModels.Fetch.Response(isError: true, message: "Dados não encontrados", pulls: data))
            }
            
        }
        
    }
    
}
