
//  ResetPasswordVC.swift
//  Aqar
//  Created by heba isaa on 01/03/2022.

import UIKit

class ResetPasswordVC: UIViewController {
var email=""
    @IBOutlet weak var newPasswordTxt: UITextField!
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: ConfirmationCodeVC.instantiate())
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        do{
                let newPassword = try newPasswordTxt.validatedText(validationType: .requiredField(field: "password required"))
                let confirmPassword = try confirmPasswordTxt.validatedText(validationType: .requiredField(field: "password required"))
            if (newPasswordTxt.text == confirmPasswordTxt.text!){

              changePassword(email: email, password: confirmPasswordTxt.text!)
                           
            }else{
                self.showAlert(title:  "Notice", message: "passwords not match", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }

        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }

    }
    


}
extension ResetPasswordVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension ResetPasswordVC{
    func changePassword(email:String,password:String){
        internetConnectionChecker { (status) in
            if status{
                
        ProfileManager.shared.changePassword(email: email, password: password) { Response in
            
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.sceneDelegate.setRootVC(vc: ResetSuccessfullyVC.instantiate())

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
