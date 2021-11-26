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
        WebServiceSubClass.UpdateProfileApi(reqModel: reqModel, imgKey: "remove_image", image: reqImage) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                SingletonClass.sharedInstance.UserProfilData = response?.data
                userDefaults.setUserData()
                let _ = userDefaults.getUserData()
                self.profileVC?.disableData()
                Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
