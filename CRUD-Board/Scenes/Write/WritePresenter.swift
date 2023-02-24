//
//  WritePresenter.swift
//  Tweet
//
//  Created by Eunyeong Kim on 2021/08/25.
//

import Foundation

protocol WriteProtocol: AnyObject {
    func setupViews()
    func dismiss()
}

final class WritePresenter {
    private weak var viewController: WriteProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtcol

    init(
        viewController: WriteProtocol,
        userDefaultsManager: UserDefaultsManagerProtcol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupViews()
    }

    func didTapLeftBarButtonItem() {
        viewController?.dismiss()
    }

    func didTapRightBarButtonItem(text: String) {
        let tweet = Tweet(user: User.shared, contents: text)
        userDefaultsManager.setTweet(tweet) // 저장
        viewController?.dismiss()
    }
}
