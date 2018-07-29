//
//  PullRequestController.swift
//  GitTest
//
//  Created by Marcos Barbosa on 27/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import UIKit

protocol PullRequestControllerOutput {
    func fetchItems(request: PullRequestModels.Fetch.Request)
}

class PullRequestController: UIViewController {

    var output: PullRequestControllerOutput!
    var router: PullRequestRouter!
    var arrayPullRequest = [PullRequest]()
    var author = ""
    var repository = ""
    
    var tablePullRequest: UITableView = {
        var tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PullRequestConfigurator.sharedInstance.configure(viewController: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tablePullRequest)
        awakeFromNib()
        output.fetchItems(request: PullRequestModels.Fetch.Request(url: "https://api.github.com/repos/\(author)/\(repository)/pulls"))
        // Do any additional setup after loading the view.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func successFetchedItems(viewModel: PullRequestModels.Fetch.ViewModel) {
        print("sucesso 1")
        arrayPullRequest = viewModel.pulls!
        tablePullRequest.reloadData()
    }
    
    func errorFetchingItems(viewModel: PullRequestModels.Fetch.ViewModel) {
        print("error 1")
    }

}

extension PullRequestController: UITableViewDelegate, UITableViewDataSource{
    
    override func viewWillLayoutSubviews() {
        
        tablePullRequest.dataSource = self
        tablePullRequest.delegate = self
        tablePullRequest.register(PullRequestCell.self, forCellReuseIdentifier: "cell")
        
        tablePullRequest.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tablePullRequest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tablePullRequest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tablePullRequest.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrayPullRequest.count > 0 {
            tablePullRequest.backgroundView = nil
        }else{
            let label = UILabel()
            label.text = "Nenhum \"Pull Request\", foi encontrado."
            label.textAlignment = .center
            tablePullRequest.backgroundView = label
        }
        
        return arrayPullRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePullRequest.dequeueReusableCell(withIdentifier: "cell") as! PullRequestCell
        
        cell.labelTitle.text = arrayPullRequest[indexPath.row].title
        cell.labelName.text  = arrayPullRequest[indexPath.row].name
        cell.labelBody.text  = arrayPullRequest[indexPath.row].body
        
        let date = arrayPullRequest[indexPath.row].date
        let dates = date.split(separator: "T")
        
        cell.labelDate.text  = "\(dates[0])"
        
        
        if let image = arrayPullRequest[indexPath.row].photo as? String{
            let url : NSURL? = NSURL(string: image)
            if let urlImage = url{
                cell.photo.sd_setImage(with: urlImage as URL, completed: nil)
            }
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showAnotherView(navigation: self.navigationController!, source: self, sender: arrayPullRequest[indexPath.row])
    }
    
}
