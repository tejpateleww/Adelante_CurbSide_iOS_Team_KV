//
//  ProfileVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 15/11/21.
//

import UIKit
import SDWebImage
import Photos

class ProfileVC: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblName: themeLabel!
    @IBOutlet weak var btnEditAccount: submitButton!
    @IBOutlet weak var txtEmail: floatTextField!
    @IBOutlet weak var txtPhoneNumber: floatTextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vWProfileImg: UIView!
    @IBOutlet weak var btnSave: submitButton!
    @IBOutlet weak var btnIconProfile: UIButton!
    @IBOutlet weak var iconProfile: UIImageView!
    
    // MARK: - Properties
    var customTabBarController: CustomTabBarVC?
    var imagePicker = UIImagePickerController()
    var profileViewModel = ProfileViewModel()
    
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
        self.disableData()
        self.callGetUserProfile()
    }
    
    func showTabbar(){
        self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        self.customTabBarController?.showTabBar()
    }
    
    
    func setupUI(){
        
        self.imagePicker.delegate = self
        
        self.lblName.font = FontBook.bold.font(ofSize: 18)
        self.btnEditAccount.titleLabel?.font =  FontBook.regular.font(ofSize: 14)
        self.btnSave.titleLabel?.font =  FontBook.bold.font(ofSize: 18)
        
        self.vWProfileImg.layer.cornerRadius = self.vWProfileImg.frame.size.width/2
        self.vWProfileImg.clipsToBounds = true
        self.vWProfileImg.layer.borderColor = UIColor(hexString: "EFF1F4").cgColor
        self.vWProfileImg.layer.borderWidth = 2.0
        
        self.customTabBarController?.showTabBar()
        self.addNavBarImage(isLeft: true, isRight: true)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.myProfile.value, leftImage: NavItemsLeft.none.value, rightImages: [NavItemsRight.logout.value], isTranslucent: true, isShowHomeTopBar: false)
    }
    
    func setupData(){
        self.lblName.text = SingletonClass.sharedInstance.UserProfilData?.fullName ?? ""
        self.txtEmail.text = SingletonClass.sharedInstance.UserProfilData?.email ?? ""
        self.txtPhoneNumber.text =  SingletonClass.sharedInstance.UserProfilData?.phone ?? ""
        
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let ProfileURL = "\(APIEnvironment.ProfileBasrURL.rawValue)\(SingletonClass.sharedInstance.UserProfilData?.profilePicture ?? "")"
        self.imgProfile.sd_setImage(with: URL(string: ProfileURL), placeholderImage: UIImage(named: "imgProfile"), options: .refreshCached, completed: nil)
    }
    
    func setupDataFromRes(UserInfo : EditUserResProfile){
        self.lblName.text =  UserInfo.fullName ?? SingletonClass.sharedInstance.UserProfilData?.fullName ?? ""
        self.txtEmail.text = UserInfo.email ?? SingletonClass.sharedInstance.UserProfilData?.email ?? ""
        self.txtPhoneNumber.text =  UserInfo.phone ?? SingletonClass.sharedInstance.UserProfilData?.phone ?? ""
        
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let ProfileURL = "\(APIEnvironment.ProfileBasrURL.rawValue)\(UserInfo.profilePicture ?? SingletonClass.sharedInstance.UserProfilData?.profilePicture ?? "")"
        self.imgProfile.sd_setImage(with: URL(string: ProfileURL), placeholderImage: UIImage(named: "imgProfile"), options: .refreshCached, completed: nil)
    }
    
    func disableData(){
        self.txtEmail.isUserInteractionEnabled = false
        self.txtPhoneNumber.isUserInteractionEnabled = false
        self.btnSave.isHidden = true
        self.iconProfile.isHidden = true
        self.btnEditAccount.isHidden = false
    }
    
    func enableData(){
        self.btnSave.isHidden = false
        self.iconProfile.isHidden = false
        self.btnEditAccount.isHidden = true
    }
    
    func UploadImage(){
        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .alert)
        let Gallery = UIAlertAction(title: "Select photo from gallery"
                                    , style: .default, handler: { ACTION in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
            
        })
        let Camera  = UIAlertAction(title: "Select photo from camera", style: .default, handler: { ACTION in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.cameraCaptureMode = .photo
            self.present(self.imagePicker, animated: true)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { ACTION in
            
        })
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UIButton action methods
    @IBAction func BtnEditAccount(_ sender: Any) {
        self.enableData()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        self.callUpdateUserProfile()
    }
    
    @IBAction func btnUploadImgAction(_ sender: Any) {
        self.checkCamera()
    }
    
}

//MARK: - UIImagePickerControllerDelegate Method
extension ProfileVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if pickedImage == nil{
            Utilities.showAlert(AppName, message: "Please select image to upload", vc: self)
        }else{
            self.imgProfile.image = pickedImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // check camera permissin
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized: self.UploadImage()
        case .denied: alertToEncourageCameraAccessInitially()
        case .notDetermined: checkCameraAccess()
        default: alertToEncourageCameraAccessInitially()
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            alertToEncourageCameraAccessInitially()
        case .restricted:
            alertToEncourageCameraAccessInitially()
            print("Restricted, device owner must approve")
        case .authorized:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    DispatchQueue.main.async {
                        self.UploadImage()
                        print("Permission granted, proceed")
                    }
                    
                } else {
                    print("Permission denied")
                }
            }
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    DispatchQueue.main.async {
                        self.UploadImage()
                        print("Permission granted, proceed")
                    }
                    
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            print("Dafaukt casr < Image Picker class")
        }
    }
    
    func alertToEncourageCameraAccessInitially() {
        Utilities.showAlertWithTitleFromVC(vc: self, title: "", message: "Camera access required for capturing photos!", buttons: ["Cancel","Allow Camera"], isOkRed: false) { (ind) in
            if ind == 1{
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        }
    }
}

//MARK: - Api Call
extension ProfileVC{
    
    func callUpdateUserProfile(){
        self.profileViewModel.profileVC = self
        
        let UploadReq = UpdateProfileReqModel()
        UploadReq.phone = self.txtPhoneNumber.text ?? ""
        UploadReq.email = self.txtEmail.text ?? ""
        let splits = self.lblName.text?.components(separatedBy: " ")
        UploadReq.firstName = splits?[0] ?? ""
        UploadReq.lastName = splits?[1] ?? ""
        
        self.profileViewModel.webserviceProfileUpdateAPI(reqModel: UploadReq, reqImage: self.imgProfile.image!)
    }
    
    func callGetUserProfile(){
        self.profileViewModel.profileVC = self
        self.profileViewModel.webserviceGetUserInfo()
    }
    
}
