//
//  HomeController.swift
//  GitTest
//
//  Created by Marcos Barbosa on 26/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeControllerInput {
    
}

protocol HomeControllerOutput {
    func fetchItems(request: HomeModels.Fetch.Request)
}

class HomeController: UIViewController {

    var router: HomeRouter!
    var output: HomeControllerOutput!
    var page = 1
    var lastPage = 1
    var isEnd = false
    var repositories = [Repository]()
    var loading: UIViewController!
    var heightConstraint: NSLayoutConstraint!
    var booleanHeightSearch = false
    var pickerLanguage: UIPickerView!
    
    var viewSearch: UIView = {
        var view = UIView()
        view.layer.backgroundColor = UIColor(red: 37/255, green: 40/255, blue: 47/255, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textFieldLanguage: UITextField = {
        var textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.6
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var buttonSearch: UIButton = {
        var button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.setTitle("Buscar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tableHome: UITableView = {
        var tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        HomeConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 37/255, green: 40/255, blue: 47/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.kern:1.5]
        
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_search_white_18dp"), style:.plain, target:self, action: #selector(buttonAction))
        addButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func buttonAction() {
        if booleanHeightSearch {
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.heightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }else{
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.heightConstraint.constant = 60
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        booleanHeightSearch = !booleanHeightSearch
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(viewSearch)
        viewSearch.addSubview(textFieldLanguage)
        viewSearch.addSubview(buttonSearch)
        view.addSubview(tableHome)
        configureView()
        
        if LANGUAGES.count > 0 {
            textFieldLanguage.text = LANGUAGES.first
        }
        
        awakeFromNib()
        loading = alertWaiting(descricao: "Aguarde...")
        
        if let language = textFieldLanguage.text {
            
            self.navigationController?.navigationBar.topItem?.title = language
            
            output.fetchItems(request: HomeModels.Fetch.Request(url: "https://api.github.com/search/repositories?q=language:\(language)&sort=stars&page=\(page)"))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func successFetchedItems(viewModel: HomeModels.Fetch.ViewModel) {
        print("success")
        loading.dismiss(animated: true, completion: nil)
        if let repositories = viewModel.repositories{
            if repositories.count > 0 {
                lastPage = page
                for i in repositories{
                    if self.repositories.contains(where: {$0.repositoryName == i.repositoryName && $0.authorName == i.authorName}){
                        print("repository already exist in array")
                    }else{
                        self.repositories.append(i)
                    }
                }
                
                tableHome.reloadData()
            }else{
                isEnd = true
                page = lastPage
            }
        }
    }
    
    func errorFetchingItems(viewModel: HomeModels.Fetch.ViewModel) {
        loading.dismiss(animated: true, completion: nil)
        print("error na busca")
        
    }
    
    func configureView(){
        
        viewSearch.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        viewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        viewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        heightConstraint = viewSearch.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        
        buttonSearch.topAnchor.constraint(equalTo: viewSearch.topAnchor, constant: 10).isActive = true
        buttonSearch.trailingAnchor.constraint(equalTo: viewSearch.trailingAnchor, constant: -16).isActive = true
        buttonSearch.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonSearch.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonSearch.addTarget(self, action: #selector(searchLanguage(_:)), for: .touchUpInside)
        
        textFieldLanguage.topAnchor.constraint(equalTo: viewSearch.topAnchor, constant: 10).isActive = true
        textFieldLanguage.leadingAnchor.constraint(equalTo: viewSearch.leadingAnchor, constant: 16).isActive = true
        textFieldLanguage.trailingAnchor.constraint(equalTo: buttonSearch.leadingAnchor, constant: -16).isActive = true
        textFieldLanguage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pickerLanguage = UIPickerView()
        pickerLanguage.delegate = self
        pickerLanguage.dataSource = self
        textFieldLanguage.inputView = pickerLanguage
        
    }
    
    override func viewWillLayoutSubviews() {
        
        tableHome.delegate = self
        tableHome.dataSource = self
        tableHome.register(HomeCell.self, forCellReuseIdentifier: "cell")
        
        tableHome.topAnchor.constraint(equalTo: viewSearch.bottomAnchor, constant: 0).isActive = true
        tableHome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableHome.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableHome.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    @objc internal func dismissKeyboard(){
        view.endEditing(true)
    }
  
    @objc internal func searchLanguage(_ sender: UIButton){
        dismissKeyboard()
        if let language = textFieldLanguage.text {
            repositories = [Repository]()
            self.navigationController?.navigationBar.topItem?.title = language
            output.fetchItems(request: HomeModels.Fetch.Request(url: "https://api.github.com/search/repositories?q=language:\(language)&sort=stars&page=\(page)"))
        }
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell
        
        cell.labelRepName.text = self.repositories[indexPath.row].repositoryName
        cell.labelDescription.text = self.repositories[indexPath.row].repositoryDescription
        cell.labelStars.text = String(self.repositories[indexPath.row].stars)
        cell.labelForks.text = String(self.repositories[indexPath.row].forks)
        cell.labelAuthorName.text = self.repositories[indexPath.row].authorName
        
        if let image = self.repositories[indexPath.row].authorPhoto as? String{
            let url : NSURL? = NSURL(string: image)
            if let urlImage = url{
                cell.imagemRep.sd_setImage(with: urlImage as URL, completed: nil)
            }
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 1 {
            if isEnd == false{
                page += 1
                loading = alertWaiting(descricao: "Aguarde...")
                output.fetchItems(request: HomeModels.Fetch.Request(url: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(page)"))
            }else{
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showAnotherVC(navigation: self.navigationController!, source: self, sender: repositories[indexPath.row])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if booleanHeightSearch{
            buttonAction()
            dismissKeyboard()
        }
    }
    
}

extension HomeController: UIPickerViewDelegate, UIPickerViewDataSource{
  
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LANGUAGES.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return LANGUAGES[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldLanguage.text = LANGUAGES[row]
    }
    
}

