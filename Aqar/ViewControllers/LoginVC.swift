//
//  LoginVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func signupBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: SignupVC.instantiate())
    }
    @IBAction func forgetPasswordBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: ForgettenPasswordVC.instantiate())
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        do{
            
            let userEmail = try userNameTxt.validatedText(validationType: .email)
            let userPassword = try passTxt.validatedText(validationType: .requiredField(field: "password required"))
            self.showLoading()
            
            login(email: userEmail, password: userPassword)
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
}
extension LoginVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension LoginVC{
    
    func login(email:String,password:String){
        
        internetConnectionChecker { (status) in
            if status{
                
                AuthManager.shared.login(email: email, password: password) { Response in
                    switch Response{
                        
                    case let .success(response):
                        
                        do {
                            if response.status == true{
                                guard let  responsedata = response.data else {  return  }
                                do{
                                    try KeychainWrapper.set(value: "Bearer"+" "+responsedata.accessToken!  , key: responsedata.email ?? "")
                                    AppData.email = responsedata.email ?? ""
                                }
                                self.hideLoading()
                                
                                self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
                                
                            }else{
                                self.hideLoading()
                                
                                self.showAlert(title: "Failed", message: response.message, confirmBtnTitle: "ok", cancelBtnTitle: "", hideCancelBtn: true, complitionHandler: nil)
                            }
                        } catch let error {
                            self.hideLoading()
                            
                            self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                                
                            }
                        }
                    case let .failure(error):
                        self.hideLoading()
                        
                        self.showAlert(title:  "Notice", message: "something error", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        }}}
                
            }else{
                self.hideLoading()

                self.showNoInternetVC()
                
            }
        }
    }
    
    
}
