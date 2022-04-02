//
//  SignupVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class SignupVC: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signupBtn(_ sender: Any) {
        do{
            
            let email = try emailTxt.validatedText(validationType: .email)
            let username = try usernameTxt.validatedText(validationType: .username)
            let phonenum = try phoneTxt.validatedText(validationType: .requiredField(field: "phone required"))
            let password = try passwordTxt.validatedText(validationType: .requiredField(field: "password required"))
            let country = try countryTxt.validatedText(validationType: .requiredField(field: "country required"))
            signup(email: email, username: username, phoneNum: phonenum, password: password, country: country)

         
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
      

    }
    
    @IBAction func signinBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())
    }
    
}
extension SignupVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}


extension SignupVC{
    
    
    func signup(email:String,username:String,phoneNum:String,password:String,country:String){
        
        internetConnectionChecker { (status) in
            if status{
        
        ProfileManager.shared.signin(FullName: username, Country: country, PhoneNumber: phoneNum, Email: email, Password: password) { Response in
            
                  switch Response{

                        case let .success(response):
                      
                      if response.status == true{
                        
                      do {
                          self.showAlert(title: "Success", message: response.message, confirmBtnTitle: "OK", cancelBtnTitle: "", hideCancelBtn: true) { action in
                              self.sendCode(email: email)
                          }
                      } catch let error {
                     
                      }
                      }else{
                          self.showAlert(title: "Failed", message: response.message)

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
    
    
    func sendCode(email:String){
        internetConnectionChecker { (status) in
            if status{
        
        AuthManager.shared.sendRecoveryCode(email: email) { Response in
            
            switch Response{
            case let .success(response):
                if response.status == true{
                    let vc=ConfirmationCodeVC.instantiate()
                    vc.email=email
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
