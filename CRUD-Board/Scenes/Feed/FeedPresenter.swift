//
//  FeedPresenter.swift
//  CRUD-Board
//
//  Created by mobile on 2023/02/23.
//

import Foundation

protocol FeedProtocol: AnyObject {}

final class FeedPresenter {
    private weak var viewController: FeedProtocol?
    
    init (viewController: FeedProtocol) {
        self.viewController = viewController
    }
}

