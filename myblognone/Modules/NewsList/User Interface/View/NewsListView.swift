//
//  NewsListView.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

class NewsListViewController: UIViewController, NewsListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    var presenter: NewsListPresenterProtocol?
    
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: - View controller's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("app_name_text", comment: "")
        newsTableView.tableFooterView = UIView(frame: .zero)
        presenter?.didRequestNewsFeedData()
    }
    
    // MARK: - NewsListViewProtocol
    
    func updateNewsTableView(newsList: [News]) {
        print("news count: \(newsList.count)")
    }
    
    func showErrorMessage(message: String) {
        print("error: \(message)")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didRequestNewsDetail(news: News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil))
    }
    
}
