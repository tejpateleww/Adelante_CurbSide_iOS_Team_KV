//
//  NotificaitonVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 15/11/21.
//

import UIKit
import SDWebImage

class NotificaitonVC: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak var tblNotification: UITableView!
    var customTabBarController: CustomTabBarVC?
    var arrNotification: [NotificationResDatum] = []
    var notificationUserModel = NotificationUserModel()
    
    // Pull to refresh
    let refreshControl = UIRefreshControl()
    
    //shimmer
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblNotification.isUserInteractionEnabled = !isLoading
            self.tblNotification.reloadData()
        }
    }
    
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
        self.addRefreshControl()
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
        let nib2 = UINib(nibName: NotiShimmerCell.className, bundle: nil)
        self.tblNotification.register(nib2, forCellReuseIdentifier: NotiShimmerCell.className)
        let nib3 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblNotification.register(nib3, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = #colorLiteral(red: 0.8901960784, green: 0.2901960784, blue: 0.1450980392, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblNotification.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.arrNotification = []
        self.isTblReload = false
        self.isLoading = true
        self.callNotificationListApi()
    }
    
    func setupData(){
        self.callNotificationListApi()
    }
}

//MARK: - UITableview Methods
extension NotificaitonVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrNotification.count > 0 {
            return self.arrNotification.count
        } else {
            return (!self.isTblReload) ? 10 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblNotification.dequeueReusableCell(withIdentifier: NotiShimmerCell.className) as! NotiShimmerCell
        if(!self.isTblReload){
            cell.lblNotiDesc.text = DummyDataForShimmer
            cell.lblNotiTitle.text = DummyDataForShimmer
            return cell
        }else{
            if(self.arrNotification.count > 0){
                
                let cell = tblNotification.dequeueReusableCell(withIdentifier: NotificationCell.className) as! NotificationCell
                cell.selectionStyle = .none
                
                cell.lblNotiTitle.text = self.arrNotification[indexPath.row].notificationTitle ?? ""
                cell.lblNotiDesc.text = self.arrNotification[indexPath.row].descriptionField ?? ""
                
                let ProfileURL = "\(APIEnvironment.ProfileBasrURL.rawValue)\( self.arrNotification[indexPath.row].image ?? "")"
                cell.imgNoti.sd_setImage(with: URL(string: ProfileURL), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
                
                
//                if(cell.lblNotiDesc.text == StringConsts.NotiSessionExpired){
//                    cell.imgNoti.image = UIImage(named: "iconNotificationInfo")
//                }else{
//                    cell.imgNoti.image = UIImage(named: "iconNotiSuccess")
//                }
                return cell
            }else{
                let NoDatacell = self.tblNotification.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                NoDatacell.lblNoDataTitle.text = "Notifications not found."
                return NoDatacell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrNotification.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.callDeleteNotiApi(Id: self.arrNotification[indexPath.row].id ?? "")
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
    
    func callDeleteNotiApi(Id:String){
        self.notificationUserModel.notificaitonVC = self
        self.notificationUserModel.webserviceDeleteNotiAPI(NotificationId: Id)
    }

}
