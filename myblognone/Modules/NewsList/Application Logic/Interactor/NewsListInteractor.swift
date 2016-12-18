//
//  NewsListInteractor.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class NewsListInteractor: NewsListInteractorInputProtocol {

    weak var presenter: NewsListInteractorOutputProtocol?
    var APIDataManager: NewsListAPIDataManagerInputProtocol?

    init() {}
}
