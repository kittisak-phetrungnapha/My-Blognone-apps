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
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("app_name_text", comment: "")
        let aboutInfoNavItem = UIBarButtonItem(image: #imageLiteral(resourceName: "about"), style: .plain, target: self, action: #selector(requestOpeningAboutPage))
        aboutInfoNavItem.accessibilityLabel = NSLocalizedString("go_to_about_nav_button", comment: "")
        navigationItem.rightBarButtonItem = aboutInfoNavItem
        
        newsTableView.tableFooterView = UIView(frame: .zero)
        newsTableView.register(UINib(nibName: NewsListTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: NewsListTableViewCell.identifier)
        newsTableView.estimatedRowHeight = 100
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.isHidden = true
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(requestNewsFeedData), for: UIControlEvents.valueChanged)
        if #available(iOS 10.0, *) {
            newsTableView.refreshControl = refreshControl
        } else {
            newsTableView.addSubview(refreshControl)
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            refreshControl.backgroundColor = UIColor(hexString: UIColor.refreshViewBackground)
        }
    
        ProgressView.shared.show(in: view)
        requestNewsFeedData()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = newsTableView.indexPathForSelectedRow {
            newsTableView.deselectRow(at: selectionIndexPath, animated: true)
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    // MARK: -
    
    @objc func requestNewsFeedData() {
        presenter?.didRequestNewsFeedData()
    }
    
    @objc func requestOpeningAboutPage() {
        if let nav = self.navigationController {
            presenter?.requestOpeningAboutPage(fromView: nav)
        }
    }
    
    fileprivate func updatedLastUpdatedTime() {
        let title = String(format: NSLocalizedString("last_update_time_text", comment: ""), Date().getStringWith(format: "MMM d, HH:mm"))
        let attributedDict = [
            NSAttributedStringKey.font: UIFont.fontFotLastUpdateTime(),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributedDict)
        self.refreshControl.attributedTitle = attributedTitle;
    }
    
}

// MARK: - NewsListViewProtocol

extension NewsListViewController: NewsListViewProtocol {
    
    func updateNewsTableView(newsList: [News]) {
        updatedLastUpdatedTime()
        refreshControl.endRefreshing()
        ProgressView.shared.hide()
        
        self.newsList = newsList
        newsTableView.isHidden = false
        newsTableView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        refreshControl.endRefreshing()
        ProgressView.shared.hide()
        MyAlertView.shared.showWithTitle(title: NSLocalizedString("whoop_title_error_text", comment: ""), message: message)
        newsTableView.isHidden = false
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
