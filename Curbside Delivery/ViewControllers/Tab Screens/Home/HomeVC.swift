//
//  HomeVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 15/11/21.
//

import UIKit
import BetterSegmentedControl

class HomeVC: BaseViewController{
    
    //MARK: - Variables
    @IBOutlet weak var segment: myOrdersSegmentControl!
    @IBOutlet weak var tblOrders: UITableView!
    
    var customTabBarController: CustomTabBarVC?
    var selectedSegmentTag = 0
    var homeListViewModel = HomeListViewModel()
    var arrorders : [OrderListDatum] = []
    var isOrderCancelled : Bool = false
    
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
        self.setupUI()
        self.setupData()
        self.registerNib()
        self.addNotificationObs()
    }
    
    func setupUI(){
        self.addNavBarImage(isLeft: true, isRight: true)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.orders.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
        
        self.segment.setIndex(0)
        self.segment.addTarget(self,action: #selector(self.navigationSegmentedControlValueChanged(_:)),for: .valueChanged)
        
        self.tblOrders.delegate = self
        self.tblOrders.dataSource = self
        self.tblOrders.separatorStyle = .none
        self.tblOrders.showsVerticalScrollIndicator = false
        
    }
    
    func setupData(){
        self.callOrderListApi(orderType: OrderType.upcoming.rawValue)
    }
    
    func registerNib(){
        let nib = UINib(nibName: pendingOrderCell.className, bundle: nil)
        self.tblOrders.register(nib, forCellReuseIdentifier: pendingOrderCell.className)
        let nib1 = UINib(nibName: completeOrderCell.className, bundle: nil)
        self.tblOrders.register(nib1, forCellReuseIdentifier: completeOrderCell.className)
    }
    
    func addNotificationObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReloadData), name: Notification.Name("ReloadData"), object: nil)
    }
    
    @objc func ReloadData() {
        self.customTabBarController?.selectedIndex = 0
        self.segment.setIndex(1)
        self.selectedSegmentTag = 1
        self.callOrderListApi(orderType: OrderType.complete.rawValue)
    }
    
    func showTabbar(){
        self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        self.customTabBarController?.showTabBar()
    }
    
    func goToOrderDetail(orderDict: QRCodeResDatum?){
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: OrderDetailVC.className) as! OrderDetailVC
        controller.isFromScanCode = false
        controller.orderDetail = orderDict
        controller.isFromCanceledOrder = self.isOrderCancelled
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - @objc methods
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            self.selectedSegmentTag = sender.index
            self.callOrderListApi(orderType: OrderType.upcoming.rawValue)
        } else {
            self.selectedSegmentTag = sender.index
            self.callOrderListApi(orderType: OrderType.complete.rawValue)
        }
    }
    
}

//MARK: - UITableview Methods
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrorders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.selectedSegmentTag == 0){
            let cell = tblOrders.dequeueReusableCell(withIdentifier: pendingOrderCell.className) as! pendingOrderCell
            cell.selectionStyle = .none
            
            cell.lblName.text = self.arrorders[indexPath.row].username ?? ""
            cell.lblOrderId.text = "Order Id : \(self.arrorders[indexPath.row].id ?? "")"
            cell.lblOrderAmount.text = "\(CurrencySymbol)\(self.arrorders[indexPath.row].total ?? "")"
            cell.lblCarNumber.text = self.arrorders[indexPath.row].carNumber ?? ""
            cell.lblParkingNumber.text = self.arrorders[indexPath.row].parkingNo ?? ""
            
            return cell
        }else{
            let cell = tblOrders.dequeueReusableCell(withIdentifier: completeOrderCell.className) as! completeOrderCell
            cell.selectionStyle = .none
            
            cell.lblName.text = self.arrorders[indexPath.row].username ?? ""
            cell.lblOrderId.text = "Order Id : \(self.arrorders[indexPath.row].id ?? "")"
            cell.lblOrderAmount.text = "\(CurrencySymbol)\(self.arrorders[indexPath.row].total ?? "")"
            cell.lblCarNumber.text = self.arrorders[indexPath.row].carNumber ?? ""
            cell.lblParkingNumber.text = self.arrorders[indexPath.row].parkingNo ?? ""
            
            if(self.arrorders[indexPath.row].status == "5"){
                cell.vWOrderStatus.backgroundColor = UIColor(hexString: "E91B3E")
                cell.lblOrderStatus.text = "Order canceled"
            }else{
                cell.vWOrderStatus.backgroundColor = UIColor(hexString: "209413")
                cell.lblOrderStatus.text = "Order Delivered"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.selectedSegmentTag == 0){
            self.customTabBarController?.selectedIndex = 1
        }else{
            if(self.arrorders[indexPath.row].status == "5"){
                self.isOrderCancelled = true
            }else{
                self.isOrderCancelled = false
            }
            self.callOrderDetailApi(strOrderId: self.arrorders[indexPath.row].id ?? "0",strOrderType: OrderType.complete.rawValue)
        }
    }
}

//MARK: - API : OrderList
extension HomeVC{
    func callOrderListApi(orderType:String){
        self.homeListViewModel.homeVC = self
        
        let reqModel = OrderListReqModel()
        reqModel.type = orderType
        
        self.homeListViewModel.webserviceLogin(reqModel: reqModel)
    }
    
    func callOrderDetailApi(strOrderId:String, strOrderType:String){
        self.homeListViewModel.homeVC = self
        
        let reqModel = OrderDetailReqModel()
        reqModel.type = strOrderType
        reqModel.orderId = strOrderId
        
        self.homeListViewModel.webserviceOrderetail(reqModel: reqModel)
    }
}
