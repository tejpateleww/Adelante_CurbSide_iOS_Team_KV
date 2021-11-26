//
//  ForgotPAsswordViewModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 25/11/21.
//

import Foundation

class ForgotPasswordUserModel{
    weak var forgotPasswordVC : ForgotPasswordVC? = nil
    
    func webserviceForgotPassword(reqModel: ForgotPassReqModel){
        Utilities.showHud()
        WebServiceSubClass.ForgotPasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.forgotPasswordVC?.popBack()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
                }
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
