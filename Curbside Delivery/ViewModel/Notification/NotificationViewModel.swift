//
//  NotificationViewModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 24/11/21.
//

import Foundation

class NotificationUserModel{
    weak var notificaitonVC : NotificaitonVC? = nil
    
    func webserviceNotificationList(reqModel: NotificationReqModel){
        WebServiceSubClass.NotificationListApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                self.notificaitonVC?.arrNotification = response?.data ?? []
                self.notificaitonVC?.tblNotification.reloadData()
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
