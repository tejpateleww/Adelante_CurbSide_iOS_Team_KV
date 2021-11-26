//
//  CustomTabBar.swift
//  CurbSide
//
//  Created by Apple on 11/11/21.
//

import Foundation
import AVKit
class CustomTabBar: UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.clipsToBounds = false
//        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
//        layer.shadowOffset = CGSize(width: -3, height: 0)
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.3
        
//        self.backgroundImage = UIImage.from(color: .white)
    }

    
    override func layoutSubviews() {
          super.layoutSubviews()
          self.isTranslucent = true
          var tabFrame            = self.frame
          tabFrame.size.height    = 55 + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero)
          tabFrame.origin.y       = self.frame.origin.y +   ( self.frame.height - 55 - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero))
          self.layer.cornerRadius = 0
          self.frame            = tabFrame

          self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })


      }

}

var selectedTabIndex = 1

extension CustomTabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        lastSelectedIndex = tabBarController.selectedIndex
        return true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        selectedTabIndex = tabBarController.selectedIndex
        
        let newNavVC = tabBarController.children[selectedTabIndex]
        if newNavVC.isKind(of: UINavigationController.self) {
            let vc = newNavVC as! UINavigationController
            if vc.children.count > 1 {
                vc.popToRootViewController(animated: false)
            }
            
        }
//                    if let navVc = tabBarController.children.first {
//
//                    }
//
       
    }
}
class CustomTabBarVC: UITabBarController {
    var lastSelectedIndex = 0
 
    private let customTabBarView: UIView = {
               
             let view = UIView(frame: .zero)

             view.backgroundColor = .white
             view.layer.cornerRadius = 0
             view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
             view.clipsToBounds = true

             view.layer.masksToBounds = false
             view.layer.shadowColor = UIColor.black.cgColor
             view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
             view.layer.shadowOpacity = 0.12
             view.layer.shadowRadius = 10.0

       return view
     }()
    
    let containerView: UIView = {
               
     let view = UIView(frame: .zero)
     view.backgroundColor = .white
            
       return view
     }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 0
        // Do any additional setup after loading the view.
        addcoustmeTabBarView()
        hideTabBarBorder()
      
       // tabBarFirstTimeHeight = tabBar.frame.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addCustomTabBarView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    private func addCustomTabBarView() {
        
//        print("CustomTabBarController: addCustomTabBarView")

        customTabBarView.frame = CGRect(x: 0.0, y: 0.0, width: tabBar.frame.width, height: tabBar.frame.height)
        containerView.frame = tabBar.frame
        containerView.addSubview(customTabBarView)
        view.addSubview(containerView)
        
        view.bringSubviewToFront(self.tabBar)
     }
    private func addcoustmeTabBarView() {
        if #available(iOS 13.0, *) {
           
            let appearance = tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            tabBar.standardAppearance = appearance
            
        } else {
            // Fallback on earlier versions
        };
       
    }
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
//        tabBar.layer.shadowColor = UIColor.black.cgColor
       
      
    }
    
    func hideTabBar() {
        self.tabBar.isHidden = true
        self.containerView.isHidden = true
       // coustmeTabBarView.isHidden = true
    }

    func showTabBar() {
        self.tabBar.isHidden = false
        self.containerView.isHidden = false
        //coustmeTabBarView.isHidden = false
    }
}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
