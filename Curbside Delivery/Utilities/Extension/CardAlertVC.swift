//
//  CardAlertVC.swift
//  Populaw
//
//  Created by Hiral Jotaniya on 11/08/21.
//

import UIKit

//class CardAlertVC: BaseViewController {
//    @IBOutlet weak var lblHeader : ThemeLabel!
//    @IBOutlet weak var lblInfo : ThemeLabel!
//    @IBOutlet weak var contentView: UIView!
//
//    var completion: (() -> Void)?
//    var info = ""
//    var header = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar(hasBackImage: true, title: .none)
//        lblHeader.text = header
//        lblInfo.text = info
//        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
//        tapGesture.minimumPressDuration = 0
//        contentView.isUserInteractionEnabled = true
//        contentView.addGestureRecognizer(tapGesture)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.view.transform = .init(scaleX: 0.5, y: 0.5)
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
//            self.view.transform = .identity
//        })
//    }
//
//    @objc func viewTapped(_ gesture: UILongPressGestureRecognizer) {
//        switch gesture.state {
//        case .began:
//            gesture.view?.alpha = 0.5
//        case .ended:
//            gesture.view?.alpha = 1
//            self.dismiss(animated: false) {
//                self.completion?()
//            }
//        default:
//            break
//        }
//    }
//
//}
