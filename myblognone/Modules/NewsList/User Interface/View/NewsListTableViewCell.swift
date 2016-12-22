//
//  NewsListTableViewCell.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/21/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    static let identifier = "NewsListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        creatorLabel.font = UIFont.italicSystemFont(ofSize: 17)
    }
    
    func setup(with news: News) {
        titleLabel.text = news.title
        creatorLabel.text = news.creator
        dateTimeLabel.text = news.pubDate
    }
    
}
