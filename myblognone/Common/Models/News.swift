//
//  News.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

struct News {
    
    var title: String!
    var link: String!
    var detail: String!
    var pubDate: String!
    var creator: String!
    
    init(title: String?, link: String?, detail: String?, pubDate: String?, creator: String?) {
        self.title = title ?? ""
        self.link = link ?? ""
        self.detail = detail ?? ""
        self.pubDate = pubDate ?? ""
        self.creator = creator ?? ""
    }
    
}
