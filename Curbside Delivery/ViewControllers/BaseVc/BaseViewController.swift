//
//  ViewController.swift
//  HJM
//
//  Created by EWW082 on 19/08/19.
//  Copyright © 2019 EWW082. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var vwNavHomeTopBar = UIView()
    let lblNavAddressHome = myLocationLabel()
    var btnNavAddressHome = UIButton()
    var btnNavLike = UIButton()
    func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor, naviTitle : String, leftImage : String , rightImages : [String], isTranslucent : Bool, isShowHomeTopBar:Bool)
    {
        UIApplication.shared.statusBarStyle = .lightContent
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false;
        
        controller.navigationController?.navigationBar.isTranslucent = isTranslucent
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = colors.white.value;
        let label = navigationTitleLabel()
        label.text = naviTitle
        label.textAlignment = .center
        label.textColor = colors.black.value
        label.font = FontBook.bold.font(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        controller.navigationItem.titleView?.clipsToBounds = false
        controller.navigationItem.titleView = label
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        if isShowHomeTopBar {
            vwNavHomeTopBar.frame = CGRect(x: 10, y: 0, width: ((controller.navigationController?.navigationBar.frame.size.width)!), height: 40)
            let verticalStack = UIStackView.init(frame: vwNavHomeTopBar.frame)
            verticalStack.axis = .vertical
            
            let lblMyLocation = myLocationLabel.init(frame: CGRect(x: 0, y: 0, width: vwNavHomeTopBar.frame.size.width, height: 16))
            lblMyLocation.text = "My Location"
            lblMyLocation.isHeader = true
            lblMyLocation.textColor = colors.myLocTitleHome.value.withAlphaComponent(0.8)
            lblMyLocation.font = FontBook.bold.font(ofSize: 16)
            verticalStack.addArrangedSubview(lblMyLocation)
            
            let horizontalStack = UIStackView.init(frame: CGRect(x: 0, y: 16, width: vwNavHomeTopBar.frame.size.width, height: verticalStack.frame.size.height - 16))
            horizontalStack.spacing = 3
            horizontalStack.axis = .horizontal
            let imgLoc = UIImageView.init()
            imgLoc.image = UIImage.init(named: "location")
            horizontalStack.addArrangedSubview(imgLoc)
            
            
            
            lblNavAddressHome.textColor = colors.myLocValueHome.value
            lblNavAddressHome.font = FontBook.regular.font(ofSize: 14)
            horizontalStack.addArrangedSubview(lblNavAddressHome)
            
            let vwPen = UIView.init()
            let btnPen = UIButton.init(frame: CGRect(x: 0, y: 0, width: 28, height: 10))
            btnPen.setImage(UIImage.init(named: "editLocation"), for: .normal)
            vwPen.addSubview(btnPen)
            
            horizontalStack.addArrangedSubview(vwPen)
            
            verticalStack.addArrangedSubview(horizontalStack)
            btnNavAddressHome = UIButton.init(frame: vwNavHomeTopBar.frame)
            
            vwNavHomeTopBar.addSubview(btnNavAddressHome)
            vwNavHomeTopBar.addSubview(verticalStack)
            controller.navigationItem.titleView = vwNavHomeTopBar
        }
        
        if leftImage != "" {
            if leftImage == NavItemsLeft.back.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btnLeft.setImage(UIImage.init(named: "nav_back"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                LeftView.addSubview(btnLeft)
                
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            }
        }
        if rightImages.count != 0 {
            var arrButtons = [UIBarButtonItem]()
            rightImages.forEach { (title) in
                if title == NavItemsRight.notifBell.value {
                    let vwNotif = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    
                    let btnNotif = UIButton.init()
                    btnNotif.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    btnNotif.setImage(UIImage.init(named: "notif"), for: .normal)
                    
                    //btnNotif.addTarget(self, action: #selector(OpenNotificationsVC(_:)), for: .touchUpInside)
                    btnNotif.layer.setValue(controller, forKey: "controller")
                    vwNotif.addSubview(btnNotif)
                    
                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: vwNotif)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.liked.value {
                    let vwLike = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    
                    btnNavLike = UIButton.init()
                    btnNavLike.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    btnNavLike.setImage(UIImage.init(named: "ic_RestaurantdisLiked"), for: .normal)
                    btnNavLike.setImage(UIImage.init(named: "ic_RestaurantLiked"), for: .selected)
                    btnNavLike.setImage(UIImage.init(named: "ic_RestaurantLiked"), for: .highlighted)
                    //btnNavLike.addTarget(self, action: #selector(likeDislikeReaustrant(_:)), for: .touchUpInside)
                    btnNavLike.layer.setValue(controller, forKey: "controller")
                    vwLike.addSubview(btnNavLike)
                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: vwLike)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.clearAll.value {
                    let vwClearAll = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
                    
                    let btnClearALl = UIButton.init()
                    btnClearALl.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
                    btnClearALl.setTitle("Clear All", for: .normal)
                    btnClearALl.setTitleColor(colors.appOrangeColor.value, for: .normal)
                    btnClearALl.titleLabel?.font = FontBook.bold.font(ofSize: 13)
                    //btnClearALl.addTarget(self, action: #selector(self.btnClearAllClick), for: .touchUpInside)
                    btnClearALl.layer.setValue(controller, forKey: "controller")
                    vwClearAll.addSubview(btnClearALl)
                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: vwClearAll)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.logout.value {
                    let vwClearAll = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
                    
                    let btnClearALl = UIButton.init()
                    btnClearALl.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
                    btnClearALl.setTitle("Logout", for: .normal)
                    btnClearALl.setTitleColor(colors.appOrangeColor.value, for: .normal)
                    btnClearALl.titleLabel?.font = FontBook.bold.font(ofSize: 15)
                    btnClearALl.addTarget(self, action: #selector(self.btnLogoutAction), for: .touchUpInside)
                    btnClearALl.layer.setValue(controller, forKey: "controller")
                    vwClearAll.addSubview(btnClearALl)
                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: vwClearAll)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                }
                
            }
            controller.navigationItem.rightBarButtonItems = arrButtons
        }
        
    }
    
    @objc func btnBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnLogoutAction() {
        BaseViewController.showAlertWithTitleFromVC(vc: self, title: AppName, message: "Are you sure you want to Logout?", buttons: ["Cancel", "OK"]) { index in
            if index == 1{
                AppDelegate.current.clearData()
            }
        }
    }

    func setNavBarWithMenu(Title:String, IsNeedRightButton:Bool){
        
        if Title == "Home"
        {
            self.title = title?.uppercased()
        }
        else
        {
            self.navigationItem.title = Title.uppercased()
        }
        
        self.navigationController?.navigationBar.barTintColor = colors.black.value
        self.navigationController?.navigationBar.tintColor = colors.black.value
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
  
    func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}

