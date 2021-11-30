//
//  OfflineVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 18/11/21.
//

import UIKit
import Lottie

class OfflineVC: BaseViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblOffline: UILabel!
    @IBOutlet weak var btnRetry: submitButton!
    @IBOutlet var vWAnimation: AnimationView!
    
    //MARK: - Life-Cycle methods
    override func viewWillAppear(_ animated: Bool) {
        self.PlayAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.setupUI()
    }
    
    func PlayAnimation(){
        let path = Bundle.main.path(forResource: "Offline",ofType: "json") ?? ""
        self.vWAnimation.animation = Animation.filepath(path)
        self.vWAnimation!.loopMode = .loop
        self.vWAnimation!.contentMode = .scaleAspectFill
        self.vWAnimation.play()
    }
    
    func setupUI(){
        self.lblOffline.font = FontBook.regular.font(ofSize: 15)
    }
    
    //MARK: - IBOutlet Action methods
    @IBAction func btnRetryAction(_ sender: Any) {
        AppDelegate.current.checkConnction()
    }
}
