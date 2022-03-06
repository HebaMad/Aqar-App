
//  ResetPasswordVC.swift
//  Aqar
//  Created by heba isaa on 01/03/2022.

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var newPasswordTxt: UITextField!
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        do{
            
 let newPassword = try newPasswordTxt.validatedText(validationType: .username)
 let confirmPassword = try confirmPasswordTxt.validatedText(validationType: .password)
            
 self.sceneDelegate.setRootVC(vc: ResetSuccessfullyVC.instantiate())

            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }

    }
    


}
extension ResetPasswordVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
