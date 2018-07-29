//
//  PullRequestModels.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

struct PullRequestModels {
    struct Fetch {
        struct Request {
            var url: String
        }
        
        struct Response {
            var isError: Bool
            var message: String?
            var pulls: [PullRequest]?
        }
        
        struct ViewModel {
            var isError: Bool
            var message: String
            var pulls: [PullRequest]?
        }
        
    }
}
