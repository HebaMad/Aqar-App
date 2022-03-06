//
//  ForgettenPasswordVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ForgettenPasswordVC: UIViewController {

    @IBOutlet weak var phoneNumTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendButton(_ sender: Any) {
        do{
            
            let phone = try phoneNumTxt.validatedText(validationType: .phoneNumber)
  
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
    

}
extension ForgettenPasswordVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
