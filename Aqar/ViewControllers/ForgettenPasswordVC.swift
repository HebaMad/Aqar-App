//
//  ForgettenPasswordVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ForgettenPasswordVC: UIViewController {
    var status = "signup"
    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backBtn(_ sender: Any) {
        if status == "signup"{
        self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func sendButton(_ sender: Any) {
        do{
            
            let email = try emailTxt.validatedText(validationType: .email)
            sendCode(email: email)
  
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
    

}
extension ForgettenPasswordVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension ForgettenPasswordVC{
    func sendCode(email:String){
        internetConnectionChecker { (status) in
            if status{
                
        AuthManager.shared.sendRecoveryCode(email: email) { Response in
            
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    let vc=ConfirmationCodeVC.instantiate()
                    vc.email=email
                    vc.screenName="forgetPass"
                    self.sceneDelegate.setRootVC(vc:vc)
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "something error", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
            
            
            
            
        }
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
}
