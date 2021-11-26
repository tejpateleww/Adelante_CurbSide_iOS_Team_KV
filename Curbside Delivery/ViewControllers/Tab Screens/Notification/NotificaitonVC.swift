//
//  NotificaitonVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 15/11/21.
//

import UIKit

class NotificaitonVC: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak var tblNotification: UITableView!
    var customTabBarController: CustomTabBarVC?
    var arrNotification: [NotificationResDatum] = []
    var notificationUserModel = NotificationUserModel()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showTabbar()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.registerNib()
        self.setupUI()
        self.setupData()
    }
    
    func showTabbar(){
        self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        self.customTabBarController?.showTabBar()
    }
    
    func setupUI(){
        self.customTabBarController?.showTabBar()
        self.addNavBarImage(isLeft: true, isRight: true)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.notifications.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
        
        self.tblNotification.delegate = self
        self.tblNotification.dataSource = self
        self.tblNotification.separatorStyle = .none
        self.tblNotification.showsVerticalScrollIndicator = false
        
    }
    
    func registerNib(){
        let nib = UINib(nibName: NotificationCell.className, bundle: nil)
        self.tblNotification.register(nib, forCellReuseIdentifier: NotificationCell.className)
    }
    
    func setupData(){
        self.callNotificationListApi()
    }
}

//MARK: - UITableview Methods
extension NotificaitonVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblNotification.dequeueReusableCell(withIdentifier: NotificationCell.className) as! NotificationCell
        cell.selectionStyle = .none
        
        cell.lblNotiTitle.text = self.arrNotification[indexPath.row].notificationTitle ?? ""
        cell.lblNotiDesc.text = self.arrNotification[indexPath.row].descriptionField ?? ""
        
        if(cell.lblNotiDesc.text == StringConsts.NotiSessionExpired){
            cell.imgNoti.image = UIImage(named: "iconNotificationInfo")
        }else{
            cell.imgNoti.image = UIImage(named: "iconNotiSuccess")//iconNotiFail
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
        }
    }
}


//MARK: - API : OrderList
extension NotificaitonVC{
    func callNotificationListApi(){
        self.notificationUserModel.notificaitonVC = self
        
        let reqModel = NotificationReqModel()
        self.notificationUserModel.webserviceNotificationList(reqModel: reqModel)
    }
}
