//
//  PullRequestCell.swift
//  GitTest
//
//  Created by Marcos Barbosa on 28/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import UIKit

class PullRequestCell: UITableViewCell {

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
    
    var photo: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var labelTitleName: UILabel = {
        var label = UILabel()
        label.text = "Nome"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelName: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitlePR: UILabel = {
        var label = UILabel()
        label.text = "Título"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitle: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitleDate: UILabel = {
        var label = UILabel()
        label.text = "Data de criação"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelDate: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTitleBody: UILabel = {
        var label = UILabel()
        label.text = "Descrição"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelBody: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        self.addSubview(viewCard)
        viewCard.addSubview(photo)
        viewCard.addSubview(labelTitleName)
        viewCard.addSubview(labelName)
        viewCard.addSubview(labelTitlePR)
        viewCard.addSubview(labelTitle)
        viewCard.addSubview(labelTitleDate)
        viewCard.addSubview(labelDate)
        viewCard.addSubview(labelTitleBody)
        viewCard.addSubview(labelBody)
        
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
    
    override func layoutSubviews() {
        
        viewCard.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        viewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        viewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        viewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        photo.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: 20).isActive = true
        photo.centerXAnchor.constraint(equalTo: viewCard.centerXAnchor, constant: 0).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        labelTitleName.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 12).isActive = true
        labelTitleName.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitleName.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelName.topAnchor.constraint(equalTo: labelTitleName.bottomAnchor, constant: 8).isActive = true
        labelName.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelName.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelTitlePR.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 12).isActive = true
        labelTitlePR.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitlePR.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo: labelTitlePR.bottomAnchor, constant: 8).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelTitleDate.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 12).isActive = true
        labelTitleDate.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitleDate.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelDate.topAnchor.constraint(equalTo: labelTitleDate.bottomAnchor, constant: 8).isActive = true
        labelDate.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelDate.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelTitleBody.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 12).isActive = true
        labelTitleBody.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelTitleBody.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        
        labelBody.topAnchor.constraint(equalTo: labelTitleBody.bottomAnchor, constant: 8).isActive = true
        labelBody.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 12).isActive = true
        labelBody.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -12).isActive = true
        labelBody.bottomAnchor.constraint(equalTo: viewCard.bottomAnchor, constant: -20).isActive = true
    }
    
}
