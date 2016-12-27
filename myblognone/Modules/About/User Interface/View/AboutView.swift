//
//  AboutView.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UITableViewController, AboutViewProtocol {
    var presenter: AboutPresenterProtocol?
    
    @IBOutlet weak var versionTitleLabel: UILabel!
    @IBOutlet weak var versionValueLabel: UILabel!
    @IBOutlet weak var sendFeedbackTitleLabel: UILabel!
    @IBOutlet weak var rateThisAppsLabel: UILabel!
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("about_title_text", comment: "")
        
        versionTitleLabel.font = UIFont.fontForVersionTitle()
        versionValueLabel.font = UIFont.fontForVersionValue()
        sendFeedbackTitleLabel.font = UIFont.fontForSendEmailFeedback()
        rateThisAppsLabel.font = UIFont.fontForRateApps()
        
        versionValueLabel.textColor = UIColor.lightGray
        
        presenter?.didRequestVersionAndBuildNumber()
    }
    
    // MARK: - AboutViewProtocol
    
    func setupVersionAndBuildNumber(input: String) {
        versionValueLabel.text = input
    }
    
}
