//
//  OrderDetailVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 16/11/21.
//

import UIKit

class OrderDetailVC: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblParkingNumber: UILabel!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblTotalItems: UILabel!
    @IBOutlet weak var tblItems: UITableView!
    @IBOutlet weak var tblItemsHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblServiceFee: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblPromocodeAmount: UILabel!
    
    @IBOutlet weak var lblCompleted: UILabel!
    @IBOutlet weak var lblCanceled: UILabel!
    
    @IBOutlet weak var lblResName: UILabel!
    @IBOutlet weak var lblResAddress: UILabel!
    @IBOutlet weak var lblTitleFoodItem: UILabel!
    @IBOutlet weak var lblTitleQtyItem: UILabel!
    @IBOutlet weak var lblTitlePriceItem: UILabel!
    @IBOutlet weak var lblTitleYourOrder: UILabel!
    @IBOutlet weak var lblTitleSubTotal: UILabel!
    @IBOutlet weak var lblTitleServiceFee: UILabel!
    @IBOutlet weak var lblTitleTax: UILabel!
    @IBOutlet weak var lblTitlePromocodeTax: UILabel!
    
    @IBOutlet weak var lblTitleParkingNumber: UILabel!
    @IBOutlet weak var lblTitleCarNumber: UILabel!
    @IBOutlet weak var lblTitleTotal: UILabel!
    
    @IBOutlet weak var btnDeliver: submitButton!
    @IBOutlet weak var stackDeliver: UIStackView!
    @IBOutlet weak var stackDeliverHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollVw: UIScrollView!
    
    @IBOutlet weak var stackParking: UIStackView!
    @IBOutlet weak var stackCar: UIStackView!
    
    @IBOutlet weak var vePromocodeHeight: NSLayoutConstraint!
    @IBOutlet weak var vWPromocode: UIView!
    
    
    var customTabBarController: CustomTabBarVC?
    var isFromScanCode : Bool = false
    var isFromCanceledOrder : Bool = false
    var orderDetail : QRCodeResDatum?
    var arrItem : [QRCodeResItem] = []
    var deliverUserModel = DeliverUserModel()
    var strQRCode : String = ""
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hideTabbar()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblItems.layer.removeAllAnimations()
        self.tblItemsHeight.constant = self.tblItems.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.registerNib()
        self.setupUI()
        self.setupData()
    }
    
    func hideTabbar(){
        self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        self.customTabBarController?.hideTabBar()
    }
    
    func setupUI(){
        
        self.addNavBarImage(isLeft: true, isRight: true)
        self.scrollVw.showsVerticalScrollIndicator = false
        self.scrollVw.showsHorizontalScrollIndicator = false
        
        if(isFromScanCode){
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.OrderDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
            self.stackDeliver.isHidden = false
            self.btnDeliver.isHidden = false
            self.lblCompleted.isHidden = true
            self.lblCanceled.isHidden = true
            self.stackDeliverHeight.constant = 50
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.CompleteOrderDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
            self.stackDeliver.isHidden = true
            self.btnDeliver.isHidden = true
            self.stackDeliverHeight.constant = 0
            
            if(self.isFromCanceledOrder == true){
                self.lblCompleted.isHidden = true
                self.lblCanceled.isHidden = false
                self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.CanceledOrderDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
            }else{
                self.lblCompleted.isHidden = false
                self.lblCanceled.isHidden = true
            }
        }
        
        self.lblName.font = FontBook.bold.font(ofSize: 25)
        self.lblParkingNumber.font = FontBook.bold.font(ofSize: 19)
        self.lblCarNumber.font = FontBook.bold.font(ofSize: 18)
        self.lblOrderID.font = FontBook.bold.font(ofSize: 13)
        self.lblTotalItems.font = FontBook.regular.font(ofSize: 15)
        self.lblTotal.font = FontBook.bold.font(ofSize: 20)
        self.lblTitleParkingNumber.font = FontBook.bold.font(ofSize: 17)
        self.lblTitleCarNumber.font = FontBook.bold.font(ofSize: 17)
        self.lblTitleTotal.font = FontBook.bold.font(ofSize: 15)
        self.lblCompleted.font = FontBook.bold.font(ofSize: 70)
        self.lblCanceled.font = FontBook.bold.font(ofSize: 70)
        
        self.lblResName.font = FontBook.bold.font(ofSize: 25)
        self.lblResAddress.font = FontBook.regular.font(ofSize: 15)
        self.lblTitleFoodItem.font = FontBook.bold.font(ofSize: 18)
        self.lblTitleQtyItem.font = FontBook.bold.font(ofSize: 18)
        self.lblTitlePriceItem.font = FontBook.bold.font(ofSize: 18)
        self.lblTitleYourOrder.font = FontBook.bold.font(ofSize: 22)
        self.lblTitleSubTotal.font = FontBook.regular.font(ofSize: 16)
        self.lblTitlePromocodeTax.font = FontBook.regular.font(ofSize: 16)
        self.lblTitleServiceFee.font = FontBook.regular.font(ofSize: 16)
        self.lblTitleTax.font = FontBook.regular.font(ofSize: 16)
        self.lblSubTotal.font = FontBook.bold.font(ofSize: 16)
        self.lblServiceFee.font = FontBook.bold.font(ofSize: 16)
        self.lblPromocodeAmount.font = FontBook.bold.font(ofSize: 16)
        self.lblTax.font = FontBook.bold.font(ofSize: 16)
        
        
        self.tblItems.delegate = self
        self.tblItems.dataSource = self
        self.tblItems.separatorStyle = .none
        self.tblItems.showsVerticalScrollIndicator = false
        self.tblItems.isScrollEnabled = false
        self.tblItems.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.completedTransform()
    }
    
    func setupData(){
        self.lblName.text = self.orderDetail?.username ?? ""
        self.lblParkingNumber.text = self.orderDetail?.parkingno ?? "-"
        self.lblCarNumber.text = (self.orderDetail?.carnumber == "") ? "-" : self.orderDetail?.carnumber
        self.lblOrderID.text = "Order Id : \(self.orderDetail?.orderId ?? "")"
        self.lblTotalItems.text = "\(self.orderDetail?.item?.count ?? 0) Food Items"
        self.lblTotal.text = "\(CurrencySymbol)\(self.orderDetail?.total ?? "")"
        self.lblSubTotal.text = "\(CurrencySymbol)\(self.orderDetail?.subTotal ?? "")"
        
        self.lblTitleServiceFee.text = "Service Fee (\(self.orderDetail?.restaurentServiceFee ?? "")%)"
        self.lblTitleTax.text = "Taxes (\(self.orderDetail?.tax ?? "")%)"
        self.lblServiceFee.text = "\(CurrencySymbol)\(self.orderDetail?.serviceFee ?? "")"
        self.lblTax.text = "\(CurrencySymbol)\(self.orderDetail?.totalRound ?? "")"
        
        self.arrItem = self.orderDetail?.item ?? []
        self.tblItems.reloadData()
        
        if(self.lblCarNumber.text == "-"){
            self.stackCar.isHidden = true
        }
        
        if(self.orderDetail?.promocode ?? "" != ""){
            self.vWPromocode.isHidden = false
            self.lblPromocodeAmount.text = "-\(CurrencySymbol)\(self.orderDetail?.discountAmount ?? "")"
            self.lblTitlePromocodeTax.text = "Promocode (\(self.orderDetail?.promocode ?? ""))"
            self.vePromocodeHeight.constant = 50
            self.view.updateFocusIfNeeded()
        }else{
            self.vWPromocode.isHidden = true
            self.vePromocodeHeight.constant = 0
            self.view.updateFocusIfNeeded()
        }
    }
    
    func registerNib(){
        let nib = UINib(nibName: OrderItemCell.className, bundle: nil)
        self.tblItems.register(nib, forCellReuseIdentifier: OrderItemCell.className)
    }
    
    func openDeliveryPopup(){
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: DeliverSuccessPopUpVC.className) as! DeliverSuccessPopUpVC
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    func completedTransform() {
        self.lblCompleted.transform = CGAffineTransform(rotationAngle: -.pi/4)
        self.lblCanceled.transform = CGAffineTransform(rotationAngle: -.pi/4)
    }
    
    //MARK: - UIButton action methods
    @IBAction func btnDeliverAction(_ sender: Any) {
        self.callDeliverApi()
    }
    
}

//MARK: - UITableview Methods
extension OrderDetailVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblItems.dequeueReusableCell(withIdentifier: OrderItemCell.className) as! OrderItemCell
        cell.selectionStyle = .none
        cell.lblItemName.text = self.arrItem[indexPath.row].restaurantItemName ?? ""
        cell.lblItemQty.text = self.arrItem[indexPath.row].quantity ?? ""
        cell.lblDate.text = self.arrItem[indexPath.row].date ?? ""
        cell.lblItemPrice.text = "\(CurrencySymbol)\(self.arrItem[indexPath.row].subTotal ?? "")"
        cell.lblDescription.text = self.arrItem[indexPath.row].description ?? ""
        
        if(indexPath.row == self.arrItem.count - 1){
            cell.vWBottom.isHidden = true
        }else{
            cell.vWBottom.isHidden = false
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - API : Scan QR
extension OrderDetailVC{
    func callDeliverApi(){
        self.deliverUserModel.orderDetailVC = self
        
        let reqModel = OrderDeliveryReqModel()
        reqModel.userId = orderDetail?.userId
        reqModel.orderId = orderDetail?.orderId
        self.deliverUserModel.webserviceDeliver(reqModel: reqModel)
    }
}
