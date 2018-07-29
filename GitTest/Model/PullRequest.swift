//
//  PullRequest.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

class PullRequest {
    
    private var _name: String
    private var _photo: String
    private var _title: String
    private var _date: String
    private var _body: String
    private var _url: String
    
    init() {
        _name = ""
        _photo = ""
        _title = ""
        _date = ""
        _body = ""
        _url = ""
    }
    
//    _name
    var name: String{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    
//    _photo
    var photo: String{
        get{
            return _photo
        }
        set{
            _photo = newValue
        }
    }
    
//    _title
    var title: String{
        get{
            return _title
        }
        set{
            _title = newValue
        }
    }
    
//    _date
    var date: String{
        get{
            return _date
        }
        set{
            _date = newValue
        }
    }
    
//    _body
    var body: String{
        get{
            return _body
        }
        set{
            _body = newValue
        }
    }
    
//    url
    var url: String{
        get{
            return _url
        }
        set{
            _url = newValue
        }
    }
}
