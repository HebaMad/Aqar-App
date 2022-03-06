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
            
            let userEmail = try userNameTxt.validatedText(validationType: .username)
            let userPassword = try passTxt.validatedText(validationType: .password)
      self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())

        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
}
extension LoginVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
