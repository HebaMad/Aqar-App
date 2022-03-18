//
//  LogoutAlertVC.swift
//  Aqar
//
//  Created by heba isaa on 02/03/2022.
//

import UIKit

class LogoutAlertVC: UIViewController {
var command = ""
    var email = ""
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var deleteBtn: UIButtonDesignable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteBtnHidden()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))
        

    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
dismiss(animated: true, completion: nil)
        
    }
 
    @IBAction func yesBtn(_ sender: Any) {
        do{
            try KeychainWrapper.set(value: "" , key: email )
            AppData.email = email
            self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())

        }catch let error {
            
            self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
            }
    }
    }
    @IBAction func noBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    func  deleteBtnHidden(){
        if command == "logout"{
            
            deleteBtn.isHidden = true
            
        }else{
            
            deleteBtn.isHidden = false

        }
    }
    
    
}
extension LogoutAlertVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
