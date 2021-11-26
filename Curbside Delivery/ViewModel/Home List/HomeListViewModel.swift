//
//  HomeListViewModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 23/11/21.
//

import Foundation

class HomeListViewModel{
    weak var homeVC : HomeVC? = nil
    
    func webserviceLogin(reqModel: OrderListReqModel){
        Utilities.showHud()
        WebServiceSubClass.OrderListApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.homeVC?.arrorders = response?.data ?? []
                self.homeVC?.tblOrders.reloadData()
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceOrderetail(reqModel: OrderDetailReqModel){
        Utilities.showHud()
        WebServiceSubClass.OrderDetailApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.homeVC?.goToOrderDetail(orderDict: response?.data)
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
