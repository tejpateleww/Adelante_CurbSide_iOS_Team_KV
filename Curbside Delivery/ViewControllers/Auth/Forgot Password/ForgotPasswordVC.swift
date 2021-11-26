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
        var strTitle : String?
        
        if(self.txtEmailOrPhone.text == ""){
            Toast.show(title: StringConsts.Required, message: "Please enter email", state: .info)
            return false
        }
        let checkEmail = self.txtEmailOrPhone.validatedText(validationType: .email)

        if !checkEmail.0{
            strTitle = checkEmail.1
        }
        
        if let str = strTitle{
            Toast.show(title: StringConsts.Required, message: str, state: .info)
            return false
        }
        
        return true
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
