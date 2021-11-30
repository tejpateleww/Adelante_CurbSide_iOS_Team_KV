//
//  ProfileViewModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 24/11/21.
//

import Foundation
import UIKit

class ProfileViewModel{
    
    weak var profileVC : ProfileVC? = nil

    func webserviceProfileUpdateAPI(reqModel: UpdateProfileReqModel, reqImage : UIImage){
        Utilities.showHud()
        WebServiceSubClass.UpdateProfileApi(reqModel: reqModel, imgKey: "profile_picture", image: reqImage) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.profileVC?.callGetUserProfile()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
                }
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceGetUserInfo(){
        Utilities.showHud()
        WebServiceSubClass.getUserProfileApi{ (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.profileVC?.setupDataFromRes(UserInfo: (response?.profile)!)
                self.profileVC?.disableData()
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
