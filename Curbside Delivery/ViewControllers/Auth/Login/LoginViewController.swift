//
//  LoginViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblTitle: themeTitleLabel!
    @IBOutlet weak var txtEmail : floatTextField!
    @IBOutlet weak var txtPassword : floatTextField!
    @IBOutlet weak var btnForgotPassword: submitButton!
    @IBOutlet weak var lblSignin: themeLabel!
    @IBOutlet weak var btnPasswordVisible: UIButton!
    
    var loginUserModel = LoginUserModel()
    var ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."
    var RISTRICTED_CHARACTERS_FOR_PASSWORD = " "
    
    //MARK: - Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtEmail.text = ""
        self.txtPassword.text = ""
        AppDelegate.current.checkConnction()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.addNavBarImage(isLeft: true, isRight: true)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appOrangeColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, isShowHomeTopBar: false)
        self.lblTitle.text = "Welcome Back"
        self.txtEmail.placeholder = "Email / Phone Number"
        self.txtPassword.placeholder = "Password"
        self.btnForgotPassword.setTitle("Forgot Password", for: .normal)
        self.lblSignin.text = "Sign In"
        self.txtEmail.autocorrectionType = .no
    }
    
    func validation()->Bool{
        var strTitle : String?
        
        if(self.txtEmail.text == ""){
            Toast.show(title: StringConsts.Required, message: "Please enter email or phone", state: .info)
            return false
        }
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let checkPhone = self.txtEmail.validatedText(validationType: .phoneNo)
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !password.0{
            strTitle = password.1
        }
        
        if (checkEmail.0 || checkPhone.0) && password.0 {
            return true
        } else {
            if(strTitle == nil){
                Toast.show(title: StringConsts.Required, message: "Please enter valid email or phone", state: .info)
                return false
            }else{
                Toast.show(title: StringConsts.Required, message: strTitle ?? "", state: .info)
                return false
            }
        }
    }
    
    //MARK: - IBActions methods
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
        let controller = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: ForgotPasswordVC.className) as! ForgotPasswordVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnShowPasswordTap(_ sender: UIButton) {
        let isvisible = txtPassword.isSecureTextEntry
        txtPassword.isSecureTextEntry = !isvisible
        btnPasswordVisible.isSelected =  !btnPasswordVisible.isSelected
    }
    
    @IBAction func btnlogin(_ sender: Any) {
        if validation(){
            self.callLoginApi()
        }
    }
}

//MARK: - TextField Delegate
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case self.txtEmail :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
            
        case self.txtPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        default:
            print("")
        }
        return true
    }
}

//MARK: - API : Login
extension LoginViewController{
    func callLoginApi(){
        self.loginUserModel.loginVC = self
        
        let reqModel = LoginRequestModel()
        reqModel.userName = self.txtEmail.text ?? ""
        reqModel.password = self.txtPassword.text ?? ""
        self.loginUserModel.webserviceLogin(reqModel: reqModel)
    }
}

