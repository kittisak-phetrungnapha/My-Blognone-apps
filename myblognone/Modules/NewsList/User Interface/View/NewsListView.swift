//
//  NewsListView.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

class NewsListViewController: UIViewController {
    var presenter: NewsListPresenterProtocol?
    
    @IBOutlet weak var newsTableView: UITableView!
    fileprivate var newsList: [News]?
    var refreshControl: UIRefreshControl!
    
    // MARK: - View controller's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("app_name_text", comment: "")
        
        newsTableView.tableFooterView = UIView(frame: .zero)
        newsTableView.register(UINib(nibName: NewsListTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: NewsListTableViewCell.identifier)
        newsTableView.estimatedRowHeight = 100
        newsTableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(requestNewsFeedData), for: UIControlEvents.valueChanged)
        if #available(iOS 10.0, *) {
            newsTableView.refreshControl = refreshControl
        } else {
            newsTableView.addSubview(refreshControl)
        }
    
        ProgressView.shared.show()
        requestNewsFeedData()
    }
    
    func requestNewsFeedData() {
        presenter?.didRequestNewsFeedData()
    }
    
}

// MARK: - NewsListViewProtocol

extension NewsListViewController: NewsListViewProtocol {
    
    func updateNewsTableView(newsList: [News]) {
        refreshControl.endRefreshing()
        ProgressView.shared.hide()
        
        self.newsList = newsList
        newsTableView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        refreshControl.endRefreshing()
        ProgressView.shared.hide()
        MyAlertView.shared.showWithTitle(title: message, message: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        guard let news = newsList?[indexPath.row] else {
            return cell
        }
        
        cell.setup(with: news)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = newsList?[indexPath.row] else { return }
        presenter?.didRequestNewsDetail(news: news)
    }
    
}
