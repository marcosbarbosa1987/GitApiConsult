//
//  HomeCell.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    var viewCard: UIView = {
        var view = UIView()
        view.layer.shadowOffset = CGSize(width: 3, height: -3)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.6
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var labelRepName: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.backgroundColor = UIColor(red: 37/255, green: 40/255, blue: 47/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imagemRep: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.shadowOffset = CGSize(width: 3, height: -2)
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var labelTitleDescription: UILabel = {
       var label = UILabel()
        label.text = "Descrição"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelDescription: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitleStars: UILabel = {
        var label = UILabel()
        label.text = "Stars"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelStars: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitleForks: UILabel = {
        var label = UILabel()
        label.text = "Forks"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelForks: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitleAuthorName: UILabel = {
        var label = UILabel()
        label.text = "Nome do autor"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelAuthorName: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        self.addSubview(viewCard)
        viewCard.addSubview(imagemRep)
        viewCard.addSubview(labelRepName)
        viewCard.addSubview(labelTitleDescription)
        viewCard.addSubview(labelDescription)
        
        viewCard.addSubview(labelTitleStars)
        viewCard.addSubview(labelStars)
        
        viewCard.addSubview(labelTitleForks)
        viewCard.addSubview(labelForks)
        
        viewCard.addSubview(labelTitleAuthorName)
        viewCard.addSubview(labelAuthorName)
    }
    
    override func layoutSubviews() {
        
        let width = self.frame.width
        
        viewCard.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        viewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        viewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        viewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        labelRepName.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: 0).isActive = true
        labelRepName.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 0).isActive = true
        labelRepName.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: 0).isActive = true
        labelRepName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imagemRep.topAnchor.constraint(equalTo: labelRepName.bottomAnchor, constant: 20).isActive = true
        imagemRep.centerXAnchor.constraint(equalTo: viewCard.centerXAnchor, constant: 0).isActive = true
        imagemRep.widthAnchor.constraint(equalToConstant: 125).isActive = true
        imagemRep.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        labelTitleDescription.topAnchor.constraint(equalTo: imagemRep.bottomAnchor, constant: 12).isActive = true
        labelTitleDescription.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitleDescription.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelDescription.topAnchor.constraint(equalTo: labelTitleDescription.bottomAnchor, constant: 8).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        
        labelTitleStars.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 12).isActive = true
        labelTitleStars.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitleStars.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: (width / 2 - 12) * -1).isActive = true
        labelTitleStars.widthAnchor.constraint(equalToConstant: (width / 2) - 32).isActive = true
        
        labelStars.topAnchor.constraint(equalTo: labelTitleStars.bottomAnchor, constant: 8).isActive = true
        labelStars.leadingAnchor.constraint(equalTo: labelTitleStars.leadingAnchor, constant: 0).isActive = true
        labelStars.trailingAnchor.constraint(equalTo: labelTitleStars.trailingAnchor, constant: 0).isActive = true
        
        labelTitleForks.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 12).isActive = true
        labelTitleForks.leadingAnchor.constraint(equalTo: labelTitleForks.trailingAnchor, constant: 12).isActive = true
        labelTitleForks.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        labelTitleForks.widthAnchor.constraint(equalToConstant: (width / 2) - 32).isActive = true
        
        labelForks.topAnchor.constraint(equalTo: labelTitleForks.bottomAnchor, constant: 8).isActive = true
        labelForks.leadingAnchor.constraint(equalTo: labelTitleForks.leadingAnchor, constant: 0).isActive = true
        labelForks.trailingAnchor.constraint(equalTo: labelTitleForks.trailingAnchor, constant: 0).isActive = true
        
        labelTitleAuthorName.topAnchor.constraint(equalTo: labelForks.bottomAnchor, constant: 12).isActive = true
        labelTitleAuthorName.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitleAuthorName.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelAuthorName.topAnchor.constraint(equalTo: labelTitleAuthorName.bottomAnchor, constant: 8).isActive = true
        labelAuthorName.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelAuthorName.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        labelAuthorName.bottomAnchor.constraint(equalTo: viewCard.bottomAnchor, constant: -25).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }

}
