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
        view.addSubview(tableHome)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 37/255, green: 40/255, blue: 47/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_search_white_18dp"), style:.plain, target:self, action: #selector(buttonAction(_:)))
        addButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func buttonAction(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        awakeFromNib()
        loading = alertWaiting(descricao: "Aguarde...")
        output.fetchItems(request: HomeModels.Fetch.Request(url: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(page)"))
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
  
}

extension HomeController: UITableViewDelegate, UITableViewDataSource{
    
    override func viewWillLayoutSubviews() {

        tableHome.delegate = self
        tableHome.dataSource = self
        tableHome.register(HomeCell.self, forCellReuseIdentifier: "cell")

        tableHome.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableHome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableHome.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableHome.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }
    
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
    
}

