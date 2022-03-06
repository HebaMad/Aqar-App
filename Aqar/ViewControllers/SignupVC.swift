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
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signupBtn(_ sender: Any) {
        do{
            
            let email = try emailTxt.validatedText(validationType: .email)
            let username = try usernameTxt.validatedText(validationType: .username)
            let phonenum = try phoneTxt.validatedText(validationType: .phoneNumber)
            let password = try passwordTxt.validatedText(validationType: .password)
            

         
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
