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
            DispatchQueue.main.async {
                self.notificaitonVC?.refreshControl.endRefreshing()
            }
            self.notificaitonVC?.isTblReload = true
            self.notificaitonVC?.isLoading = false
            if status{
                self.notificaitonVC?.arrNotification = response?.data ?? []
                self.notificaitonVC?.tblNotification.reloadData()
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceDeleteNotiAPI(NotificationId:String){
       WebServiceSubClass.deleteNotificationApi(NotificationId: NotificationId, completion:{ (status, apiMessage, response, error) in
           if status{
               self.notificaitonVC?.callNotificationListApi()
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                   Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
               }
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        })
    }
    
}
