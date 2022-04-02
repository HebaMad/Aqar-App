//
//  ConfirmationCodeVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ConfirmationCodeVC: UIViewController {
  var email=""
    var screenName="Signup"

    @IBOutlet weak var num1: BottomBorderTextField!
    @IBOutlet weak var num2: BottomBorderTextField!
    @IBOutlet weak var num3: BottomBorderTextField!
    @IBOutlet weak var num4: BottomBorderTextField!
    @IBOutlet weak var num5: BottomBorderTextField!
    @IBOutlet weak var num6: BottomBorderTextField!
//    
    @IBOutlet weak var verificationCode: UITextField!{
        didSet {
//            if  edit == false{

            verificationCode.addTarget(self, action: #selector(handleSubmit), for: .editingChanged)
//            }else{
//
//            }
        }
    }
    
    @objc func handleSubmit() {
        guard let code = verificationCode.text, code.count > 0 else { return }
        

        let attributedString = NSMutableAttributedString(string: code)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(36), range: NSRange(location: 0, length: attributedString.length))
        self.verificationCode.attributedText = attributedString
        
        
        if code.count == 6{
            self.view.endEditing(true)

            verifyCode(email: self.email, code: code)
            
        }
        
        
        
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: ForgettenPasswordVC.instantiate())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetRecoveryDataBtn(_ sender: Any) {
        sendCode(email: self.email)
    }
    

}
extension ConfirmationCodeVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension ConfirmationCodeVC{
    func verifyCode(email:String,code:String){
        
        internetConnectionChecker { (status) in
            if status{
                
        AuthManager.shared.verifyRecoveryCode(email: email, code: code) { Response in
            switch Response{
                
            case let .success(response):
                
                if response.status == true {
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "OK", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        if self.screenName == "forgetPass"{
                            let vc = ResetPasswordVC.instantiate()
                            vc.email = email
                            self.sceneDelegate.setRootVC(vc:vc)

                        }else{
                            
                            self.sceneDelegate.setRootVC(vc:carAqarTabBarController.instantiate())

                        }
                        
                }
                }else{
                    self.showAlert(title:  "Error", message: response.message, confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
                }
       
                case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            
    
            }}
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
