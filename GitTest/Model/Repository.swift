//
//  Repository.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

class Repository{
    
    private var _repositoryName: String
    private var _repositoryDescription: String
    private var _authorName: String
    private var _authorPhoto: String
    private var _stars: Int
    private var _forks: Int
    
    
    init(){
        _repositoryName = ""
        _repositoryDescription = ""
        _authorName = ""
        _authorPhoto = ""
        _stars = 0
        _forks = 0
    }
    
//    _repositoryName
    var repositoryName: String{
        get{
            return _repositoryName
        }
        set{
            _repositoryName = newValue
        }
    }
    
//    _repositoryDescription
    var repositoryDescription: String{
        get{
            return _repositoryDescription
        }
        set{
            _repositoryDescription = newValue
        }
    }
    
//    _authorName
    var authorName: String{
        get{
            return _authorName
        }
        set{
            _authorName = newValue
        }
    }
    
//    _authorPhoto
    var authorPhoto: String{
        get{
            return _authorPhoto
        }
        set{
            _authorPhoto = newValue
        }
    }
    
//    _stars
    var stars: Int{
        get{
            return _stars
        }
        set{
            _stars = newValue
        }
    }
    
//    _forks
    var forks: Int{
        get{
            return _forks
        }
        set{
            _forks = newValue
        }
    }
}
