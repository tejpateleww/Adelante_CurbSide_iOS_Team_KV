//
//  ScanQRcodeVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 15/11/21.
//

import UIKit
import AVFoundation

class ScanQRcodeVC: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak private var scannerView: QRScannerView!{
        didSet {
            scannerView.delegate = self
        }
    }
    var customTabBarController: CustomTabBarVC?
    var scanQRUserModel = ScanQRUserModel()
    var orderDict : QRCodeResModel?
    var strQRCode : String = ""
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
        self.showTabbar()
        self.checkCameraAccess()
    }
    
    //MARK: - Custom methods
    func prepareView(){
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
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.scanQR.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
        
        scannerView.backgroundColor = UIColor.black
    }
    
    func setupData(){
        
    }
    
    func goToOrderDetail(){
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: OrderDetailVC.className) as! OrderDetailVC
        controller.isFromScanCode = true
        controller.strQRCode = self.strQRCode
        controller.orderDetail = self.orderDict?.data
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        default:
            print("Default called..")
        }
    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Error",message: "Camera access is denied",preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        present(alertController, animated: true)
    }
}

//MARK: - UITableview Methods
extension ScanQRcodeVC: QRScannerViewDelegate {
    func qrScanningDidStop() {
        //let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
        //scanButton.setTitle(buttonTitle, for: .normal)
    }
    
    func qrScanningDidFail() {
        print("Scanning Failed. Please try again")
        //presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        scannerView.stopScanning()
        print("QR code found :\(str ?? "") ")
        self.strQRCode = str ?? ""
        self.callScanApi(strQRCode: self.strQRCode)
        
    }
}

//MARK: - API : Scan QR
extension ScanQRcodeVC{
    func callScanApi(strQRCode:String){
        self.scanQRUserModel.scanVC = self
        
        let reqModel = QRCodeReqModel()
        reqModel.qrCode = strQRCode
        
        self.scanQRUserModel.webserviceLScanQR(reqModel: reqModel)
    }
}

