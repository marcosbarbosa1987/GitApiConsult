//
//  HomeModels.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

struct HomeModels{
    
    struct Fetch{
        
        struct Request{
            var url: String
        }
        
        struct Response{
            var isError: Bool
            var message: String?
            var repositories: [Repository]?
        }
        
        struct ViewModel{
            var isError: Bool
            var message: String?
            var repositories: [Repository]?
        }
        
    }
    
}
