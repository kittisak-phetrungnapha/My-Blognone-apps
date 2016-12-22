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
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    static let identifier = "NewsListTableViewCell"
    static let cellHeight: CGFloat = 124
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with news: News) {
        titleLabel.text = news.title
        detailLabel.text = news.detail
        dateTimeLabel.text = news.pubDate
    }
    
}
