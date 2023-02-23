//
//  TabbarController.swift
//  CRUD-Board
//
//  Created by mobile on 2023/02/23.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // TabbarItem 반복하기 좋은 팁 ✅
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases
            .map { tabCase in
                let viewController = tabCase.viewController
                viewController.tabBarItem = UITabBarItem(
                    title: tabCase.title,
                    image: tabCase.icon.default,
                    selectedImage: tabCase.icon.selected
                )

                return viewController
            }

        self.viewControllers = tabBarViewControllers
    }
}


