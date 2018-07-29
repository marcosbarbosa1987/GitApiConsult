//
//  UIViewController+alert.swift
//  WebMotorsTest
//
//  Created by Marcos Barbosa on 23/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    func alertWaiting(descricao:String) -> UIAlertController {
        
        let alert = UIAlertController(title: "", message: descricao, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        return alert
        
    }
    
}
