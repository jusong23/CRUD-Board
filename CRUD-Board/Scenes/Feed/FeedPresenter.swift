//
//  FeedPresenter.swift
//  Tweet
//
//  Created by Eunyeong Kim on 2021/08/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol FeedProtocol: AnyObject {
    func setupView()
    func reloadTableView()
    func moveToTweetViewController(with tweet: Tweet)
    func moveToWriteViewController()
    func callAPI_vc(_ listElement: [ListElement])
}

final class FeedPresenter: NSObject {
    private weak var viewController: FeedProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtcol
    private let disposeBag = DisposeBag()
    private let networkService = NetworkService()
//    private var listElement = BehaviorSubject<[ListElement]>(value: [])

    private var tweets: [Tweet] = []

    init(
        viewController: FeedProtocol,
        userDefaultsManager: UserDefaultsManagerProtcol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupView()
    }

    func viewWillAppear() {
        tweets = userDefaultsManager.getTweet()
        viewController?.reloadTableView()
    }

    func callAPI() {
        networkService.getBookList()
            .subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global()))
            .observe(on: MainScheduler.instance)
            .subscribe { event in
            switch event {
            case .next(let (listElement)):
                self.viewController?.callAPI_vc(listElement)
                self.viewController?.reloadTableView()
            case .error(let error):
                print("error: \(error), thread: \(Thread.isMainThread)")
            case .completed:
                print("completed")
            }
        }.disposed(by: disposeBag)
    }
    
    func didTapWriteButton() {
        viewController?.moveToWriteViewController()
    }
}

