//
//  FeedViewController.swift
//  CRUD-Board
//
//  Created by mobile on 2023/02/23.
//
import Floaty
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class FeedViewController: UIViewController {

    private lazy var writeButton: Floaty = {
        let float = Floaty(size: 50.0)
        float.sticky = true
        float.handleFirstItemDirectly = true
        float.addItem(title: "") { [weak self] _ in
            self?.presenter.didTapWriteButton()
        }

        float.buttonImage = Icon.write.image?.withTintColor(.white, renderingMode: .alwaysOriginal)

        return float
    }()

    // 1. ViewController 연결
    private lazy var presenter = FeedPresenter(viewController: self)
    private var listElement = BehaviorSubject<[ListElement]>(value: [])

    // 2. TableView 생성 및 addSubView
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            FeedTableViewCell.self,
            forCellReuseIdentifier: FeedTableViewCell.identifier
        )

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.callAPI()
        presenter.viewWillAppear()
    }

}

extension FeedViewController: FeedProtocol {
    
    func callAPI_vc(_ listElement: [ListElement]) {
        self.listElement.onNext(listElement)
        print("***")
        print(listElement)
        print("***")
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }

    
    func setupView() {
        navigationItem.title = "Feed"

        [tableView, writeButton].forEach {
            view.addSubview($0)
        }

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        writeButton.paddingY = tabBarItem.accessibilityFrame.height + 100
    }

    func moveToTweetViewController(with tweet: Tweet) {
        let tweetViewController = TweetViewController(tweet: tweet)
        navigationController?.pushViewController(tweetViewController, animated: true)
    }
    
    func moveToWriteViewController() {
        let writeViewController = UINavigationController(rootViewController: WriteViewController())
        writeViewController.modalPresentationStyle = .fullScreen

        present(writeViewController, animated: true)
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tweets.count
        try! listElement.value().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FeedTableViewCell.identifier,
            for: indexPath
        ) as? FeedTableViewCell

        let list_Element = try! self.listElement.value()[indexPath.row]
        cell!.listElement.onNext(list_Element)
                
//        print(try! listElement.value()[indexPath.row].title)
        
//        let tweet = tweets[indexPath.row]
//        cell?.setup(tweet: tweet)

        return cell ?? UITableViewCell()
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tweet = tweets[indexPath.row]
//        viewController?.moveToTweetViewController(with: tweet)
    }
}
