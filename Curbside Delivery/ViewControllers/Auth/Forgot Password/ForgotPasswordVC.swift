//
//  ForgotPasswordVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 18/11/21.
//

import UIKit

class ForgotPasswordVC: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var txtEmailOrPhone: floatTextField!
    @IBOutlet weak var btnSend: submitButton!
    
    var customTabBarController: CustomTabBarVC?
    var forgotPasswordUserModel = ForgotPasswordUserModel()
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."

    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.setupUI()
        self.setupData()
    }
    
    func setupUI(){
        self.addNavBarImage(isLeft: true, isRight: true)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.ForgotPassword.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
        
        self.lblForgotPassword.font = FontBook.bold.font(ofSize: 26)
    }
    
    func setupData(){
        
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func validation()->Bool{
//        var strEmailTitle : String?
//        var strPhoneTitle : String?
        
        if(self.txtEmailOrPhone.text == ""){
            Toast.show(title: StringConsts.Required, message: "Please enter email or phone", state: .info)
            return false
        }
        let checkEmail = self.txtEmailOrPhone.validatedText(validationType: .email)
        let checkPhone = self.txtEmailOrPhone.validatedText(validationType: .phoneNo)
        
//        if !checkEmail.0{
//            strEmailTitle = checkEmail.1
//        }else if !checkPhone.0{
//            strPhoneTitle = checkPhone.1
//        }
        
        if checkEmail.0 || checkPhone.0 {
            return true
        } else {
            Toast.show(title: StringConsts.Required, message: "Please enter valid email or phone", state: .info)
            return false
        }

    }
    
    //MARK: - UIButton action methods
    @IBAction func btnSend(_ sender: Any) {
        if validation(){
            self.callForgotPasswordApi()
        }
    }

}

//MARK: - TextField Delegate
extension ForgotPasswordVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtEmailOrPhone :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
            
        default:
            print("")
        }
        return true
    }
}



//MARK: - API : OrderList
extension ForgotPasswordVC{
    
    func callForgotPasswordApi(){
        self.forgotPasswordUserModel.forgotPasswordVC = self
        
        let reqModel = ForgotPassReqModel()
        reqModel.email = self.txtEmailOrPhone.text ?? ""
        self.forgotPasswordUserModel.webserviceForgotPassword(reqModel: reqModel)
    }
}
