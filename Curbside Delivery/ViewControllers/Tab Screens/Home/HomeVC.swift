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
    
    //Pull to refresh
    let refreshControl = UIRefreshControl()
    
    //Shimmer
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblOrders.isUserInteractionEnabled = !isLoading
            self.tblOrders.reloadData()
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
        self.setupUI()
        self.setupData()
        self.registerNib()
        self.addNotificationObs()
        self.addRefreshControl()
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
        let nib2 = UINib(nibName: HomeShimmerCell.className, bundle: nil)
        self.tblOrders.register(nib2, forCellReuseIdentifier: HomeShimmerCell.className)
        let nib3 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblOrders.register(nib3, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = #colorLiteral(red: 0.8901960784, green: 0.2901960784, blue: 0.1450980392, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblOrders.addSubview(self.refreshControl)
    }
    
    func addNotificationObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReloadData), name: Notification.Name("ReloadData"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .orderPrepare, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.newOrder), name: .orderPrepare, object: nil)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.arrorders = []
        self.isTblReload = false
        self.isLoading = true
        if(self.selectedSegmentTag == 0){
            self.callOrderListApi(orderType:  OrderType.upcoming.rawValue)
        }else{
            self.callOrderListApi(orderType:  OrderType.complete.rawValue)
        }
    }
    
    @objc func ReloadData() {
        self.customTabBarController?.selectedIndex = 0
        self.segment.setIndex(1)
        self.selectedSegmentTag = 1
        self.callOrderListApi(orderType: OrderType.complete.rawValue)
    }
    
    @objc func newOrder() {
        self.segment.setIndex(0)
        self.selectedSegmentTag = 0
        
        self.arrorders = []
        self.isTblReload = false
        self.isLoading = true
        
        self.callOrderListApi(orderType: OrderType.upcoming.rawValue)
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
        //to start shimmer again
        self.arrorders = []
        self.isTblReload = false
        self.isLoading = true
        
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
        if self.arrorders.count > 0 {
            return self.arrorders.count
        } else {
            return (!self.isTblReload) ? 10 : 1
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblOrders.dequeueReusableCell(withIdentifier: HomeShimmerCell.className) as! HomeShimmerCell
        if(!self.isTblReload){
            cell.lblName.text = DummyDataForShimmer
            cell.lblOrderId.text = DummyDataForShimmer
            cell.lblOrderAmount.text =  DummyDataForShimmer
            cell.lblCarNumber.text =  DummyDataForShimmer
            cell.lblParkingNumber.text =  DummyDataForShimmer
            cell.lblTitleCarNumber.text =  DummyDataForShimmer
            cell.lblTitleOrderAmount.text =  DummyDataForShimmer
            cell.lblTitleParkingNumber.text =  DummyDataForShimmer
            return cell
        }else{
            if(self.arrorders.count > 0){
                
                if(self.selectedSegmentTag == 0){
                    let cell = tblOrders.dequeueReusableCell(withIdentifier: pendingOrderCell.className) as! pendingOrderCell
                    cell.selectionStyle = .none
                    
                    cell.lblName.text = self.arrorders[indexPath.row].username ?? ""
                    cell.lblOrderId.text = "Order Id : \(self.arrorders[indexPath.row].id ?? "")"
                    cell.lblOrderAmount.text = "\( CurrencySymbol)\(self.arrorders[indexPath.row].total ?? "")"
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
                        cell.lblOrderStatus.text = "Order Canceled"
                    }else{
                        cell.vWOrderStatus.backgroundColor = UIColor(hexString: "209413")
                        cell.lblOrderStatus.text = "Order Delivered"
                    }
                    return cell
                }
                
            }else{
                let NoDatacell = self.tblOrders.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                NoDatacell.lblNoDataTitle.text = "No order found"
                return NoDatacell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrorders.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.arrorders.count > 0){ // to avoid no data found cell tap
            if(self.selectedSegmentTag == 0){
                AppDelegate.current.orderId = self.arrorders[indexPath.row].id ?? ""
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
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
