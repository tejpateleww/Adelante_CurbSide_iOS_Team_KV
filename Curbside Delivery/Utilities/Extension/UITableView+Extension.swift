//
//  UITableView+Extension.swift
//  Populaw
//
//  Created by Gaurang on 14/09/21.
//

import UIKit

enum TableViewCellType: String {
    case post           = "PostTableViewCell"
    case postAds        = "PostAdsCell"
    case comment        = "CommentTableViewCell"
    case users          = "UsersTableViewCell"
    case titleComment   = "TitleCommentCell"
    case notification   = "NotificationCell"
    case reviews        = "ReviewsTableViewCell"

    var cellId: String {
        switch self {
        case .post:
            return "post_cell"
        case .postAds:
            return "post_ads_cell"
        case .comment:
            return "comment_cell"
        case .users:
            return "users_cell"
        case .titleComment:
            return "title_comment_cell"
        case .notification:
            return "notification_cell"
        case .reviews:
            return "review_cell"
        }
    }
}

extension UITableView {
    func registerNibCell(type: TableViewCellType) {
        self.register(UINib(nibName: type.rawValue, bundle: nil), forCellReuseIdentifier: type.cellId)
    }
}
