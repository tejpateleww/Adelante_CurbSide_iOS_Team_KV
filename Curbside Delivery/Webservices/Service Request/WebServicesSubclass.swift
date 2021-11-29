//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
import UIKit

class WebServiceSubClass{
    
    class func InitApi(completion: @escaping (Bool,String,InitResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.Init.rawValue + kAPPVesion + "/ios_customer", responseModel: InitResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func LoginApi(reqModel: LoginRequestModel, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OrderListApi(reqModel: OrderListReqModel, completion: @escaping (Bool,String,OrderListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.orderList.rawValue, requestModel: reqModel, responseModel: OrderListModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ScanQRCodeApi(reqModel: QRCodeReqModel, completion: @escaping (Bool,String,QRCodeResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.qrCodeDetails.rawValue, requestModel: reqModel, responseModel: QRCodeResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OrderDeliveredApi(reqModel: OrderDeliveryReqModel, completion: @escaping (Bool,String,QRCodeResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.orderDelivered.rawValue, requestModel: reqModel, responseModel: QRCodeResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OrderDetailApi(reqModel: OrderDetailReqModel, completion: @escaping (Bool,String,QRCodeResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.orderDetails.rawValue, requestModel: reqModel, responseModel: QRCodeResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func NotificationListApi(reqModel: NotificationReqModel, completion: @escaping (Bool,String,NotificationResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.notification.rawValue, requestModel: reqModel, responseModel: NotificationResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateProfileApi(reqModel : UpdateProfileReqModel , imgKey: String, image: UIImage, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.profileEdit.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self, image: image, imageKey: imgKey) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }

    class func ForgotPasswordApi(reqModel: ForgotPassReqModel, completion: @escaping (Bool,String,CommonResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.forgotPassword.rawValue, requestModel: reqModel, responseModel: CommonResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func deleteNotificationApi(NotificationId:String, completion: @escaping (Bool,String,CommonResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.removeNotifiaction.rawValue + NotificationId, responseModel: CommonResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
}
