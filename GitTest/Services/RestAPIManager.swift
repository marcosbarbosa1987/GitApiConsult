//
//  RestAPIManager.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIManager{
    
    
    internal func fetchRepositories(from url: String, completionHandler: @escaping (Bool, [Repository]?) -> Void){
        
        
        Alamofire.request(url).responseJSON { (response) in

            var fetchedRepositories = [Repository]()

            if let data = response.value{
 
                guard let repositories = data as? Dictionary<String, Any> else {return}

                if let repository = repositories["items"] as? NSArray{

                    for i in repository{

                        if let eachInformation = i as? Dictionary<String, Any>{

                            let uniqueRepository = Repository()

                            if let repName = eachInformation["name"] as? String{
                                uniqueRepository.repositoryName = repName
                            }

                            if let repDescription = eachInformation["description"] as? String{
                                uniqueRepository.repositoryDescription = repDescription
                            }

                            if let stars = (eachInformation["stargazers_count"] as AnyObject).integerValue{
                                uniqueRepository.stars = stars
                            }

                            if let forks = (eachInformation["forks_count"] as AnyObject).integerValue{
                                uniqueRepository.forks = forks
                            }

                            if let owner = eachInformation["owner"] as? Dictionary<String, Any>{

                                if let authorName = owner["login"] as? String{
                                    uniqueRepository.authorName = authorName
                                }

                                if let authorPhoto =  owner["avatar_url"] as? String{
                                    uniqueRepository.authorPhoto = authorPhoto
                                }

                            }

                            fetchedRepositories.append(uniqueRepository)
                        }

                    }

                }

            }

            if fetchedRepositories.count > 0 {
                completionHandler(true, fetchedRepositories)
            }else{
                completionHandler(false, fetchedRepositories)
            }

        }

    }
    
    
    internal func fetchPullRequest(from url: String, completionHandler: @escaping(Bool, [PullRequest]?) -> Void){
        
        Alamofire.request(url).responseJSON { (response) in
           
            var arrayPullRequest = [PullRequest]()
            
            if let data = response.value {
                
                if let pullSRequests = data as? NSArray{
                    
                    for pullRequest in pullSRequests{
                        let uniquePullRequest = PullRequest()
                        
                        if let eachInformation = pullRequest as? Dictionary<String, Any>{
                            
                            if let url = eachInformation["html_url"] as? String{
                                uniquePullRequest.url = url
                            }
                            
                            if let title = eachInformation["title"] as? String{
                                uniquePullRequest.title = title
                            }
                            
                            if let body = eachInformation["body"] as? String{
                                uniquePullRequest.body = body
                            }
                            
                            if let date = eachInformation["created_at"] as? String{
                                uniquePullRequest.date = date
                            }
                            
                            if let user = eachInformation["user"] as? Dictionary<String, Any>{
                                
                                if let name = user["login"] as? String{
                                    uniquePullRequest.name = name
                                }
                                
                                if let photo = user["avatar_url"] as? String{
                                    uniquePullRequest.photo = photo
                                }
                                
                            }
                            
                        }
                        arrayPullRequest.append(uniquePullRequest)
                    }
                    
                }
            }
            
            if arrayPullRequest.count > 0 {
                completionHandler(true, arrayPullRequest)
            }else{
                completionHandler(false, arrayPullRequest)
            }
            
        }
        
    }
    
}
