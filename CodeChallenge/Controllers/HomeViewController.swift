//
//  HomeViewController.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import UIKit
import Combine
import RxSwift

class HomeViewController: BaseViewController {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Reaching into the Milky Way")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
   
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.addSubview(refreshControl)
        return tableView
    }()
    
    
    var viewModel:HomeViewModel = HomeViewModel(apiService: ApiService())
    var contentList:Collection! {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    var error:String!{
        didSet{
            DispatchQueue.main.async {
                self.alert("That didn't work", self.error, execFunc: self.loadContent)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToViewModel()
        loadContent()
    }
    
    override func viewDidLayoutSubviews() {
        self.title = "The Milky Way"
        constrainViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.cancelRequests()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Navigation.toDetailsScreen {
            if segue.destination is DetailsViewController{
                let vc = segue.destination as? DetailsViewController
                vc?.item = viewModel.selectedCell
            }
        }
    }
    
    @objc func refresh(_ sender:AnyObject) {
        loadContent()
    }
   
    private func loadContent(){
        refreshControl.beginRefreshing()
        viewModel.fetchContent({items in
            switch(items){
                case .Success(let results): self.contentList = results
                case .Failure(let error): self.error = error.localizedDescription
            }
        })
    }
    
    private func subscribeToViewModel(){
        viewModel.cellSubject.subscribe(onNext: { item in
            self.viewModel.selectedCell = item
            self.performSegue(withIdentifier: Constants.Navigation.toDetailsScreen, sender: nil)
            /*
             alternatively i can inject selectedCell into DetailsView then push,
             but this requires i not instantiate this view from the storyboard
             let vc = DetailsViewController(item: self.viewModel.selectedCell)
            self.navigationController?.pushViewController(vc, animated: true)*/
        }).disposed(by: viewModel.disposeBag)
    }
    
    private func constrainViews(){
        /*tableView.frame = view.frame*/
        //we can do the above, but this would be limit us in the case
        //of multiple controls on a single screen, therefore demonstrating using constraints instead
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentList != nil {
            return contentList.items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.reuseId, for: indexPath) as? ContentCell{
            cell.content = contentList.items[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = contentList.items[indexPath.row]
        viewModel.cellSubject.on(.next(item))
       
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}








