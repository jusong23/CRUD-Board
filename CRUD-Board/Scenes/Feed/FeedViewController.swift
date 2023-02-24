//
//  FeedViewController.swift
//  CRUD-Board
//
//  Created by mobile on 2023/02/23.
//
import Floaty
import UIKit
import SnapKit

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

    // 2. TableView 생성 및 addSubView
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter

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

        presenter.viewWillAppear()
    }


    func reloadTableView() {
        tableView.reloadData()
    }

    func moveToWriteViewController() {
        let writeViewController = UINavigationController(rootViewController: WriteViewController())
        writeViewController.modalPresentationStyle = .fullScreen

        present(writeViewController, animated: true)
    }
}

extension FeedViewController: FeedProtocol {
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
}
