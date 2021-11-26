//
//  ScanQRUserModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 23/11/21.
//

import Foundation

class ScanQRUserModel{
    weak var scanVC : ScanQRcodeVC? = nil
    
    func webserviceLScanQR(reqModel: QRCodeReqModel){
        WebServiceSubClass.ScanQRCodeApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
                self.scanVC?.orderDict = response
                self.scanVC?.goToOrderDetail()
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}

class DeliverUserModel{
    weak var orderDetailVC : OrderDetailVC? = nil
    
    func webserviceDeliver(reqModel: OrderDeliveryReqModel){
        WebServiceSubClass.OrderDeliveredApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                self.orderDetailVC?.openDeliveryPopup()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
                }
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
