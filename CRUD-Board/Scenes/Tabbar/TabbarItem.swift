//
//  TabbarItem.swift
//  CRUD-Board
//
//  Created by mobile on 2023/02/23.
//

import UIKit

// ✅ feed일때, profile일때 리턴되는 title, icon, viewcontroller를 분기처리

enum TabBarItem: CaseIterable {
    case feed
    case profile
    
    var title: String {
        switch self {
        case .feed: return "Feed"
        case .profile: return "Profile"
        }
    }
    var icon: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .feed:
            return (UIImage(systemName: "list.bullet"), UIImage(systemName: "list.bullet"))
        case .profile:
            return (UIImage(systemName: "person"), UIImage(systemName: "person.fill"))
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .feed:
            return UINavigationController(rootViewController: FeedViewController())
        case .profile:
            return UIViewController()
//            return UINavigationController(rootViewController: ProfileViewController())
        }
    }
}
