//
//  ConfirmationCodeVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ConfirmationCodeVC: UIViewController {

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
        }
        
        
        
        
    }
    
    
    
    //    @objc func handleSubmit() {
//        if  txt == num1.text{
//            
//            guard let code = num1.text, code.count > 0 else { return }
//            let attributedString = NSMutableAttributedString(string: code)
//            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
//            self.num1.attributedText = attributedString
//            
//            if txt.count == 1{
//             self.num1.isEditing=false
//                self.num1.endEditing(true)
//                
//            }
//            
//            
//        }else if txt == num2.text{
//            guard let code = num2.text, code.count > 0 else { return }
//            let attributedString = NSMutableAttributedString(string: code)
//            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
//            self.num2.attributedText = attributedString
//            
//            if txt.count == 1{
//                self.num1.isEditing=false
//                num2.isEditing=true
//            }
//            
//        }else if txt == num3.text{
//            
//            guard let code = num3.text, code.count > 0 else { return }
//            let attributedString = NSMutableAttributedString(string: code)
//            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
//            self.num3.attributedText = attributedString
//            
//
//
//        }else if txt == num4.text{
//            guard let code = num4.text, code.count > 0 else { return }
//            let attributedString = NSMutableAttributedString(string: code)
//            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
//            self.num4.attributedText = attributedString
//            
//
//
//            
//        }else if txt == num5.text{
//            guard let code = num5.text, code.count > 0 else { return }
//            let attributedString = NSMutableAttributedString(string: code)
//            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
//            self.num5.attributedText = attributedString
//            
//
//
//        }else if txt == num6.text{
//            guard let code = num6.text, code.count > 0 else { return }
//            let attributedString = NSMutableAttributedString(string: code)
//            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
//            self.num6.attributedText = attributedString
//            
//
//
//            
//            
//        }
//            
//
//          if code.count == 4 {
//              self.continueOTP(code: txtOTP.text!, mobileNumber: mobileNumber)
//              self.view.endEditing(true)
//          }
//          
//          
//          
//          
//      }
//   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetRecoveryDataBtn(_ sender: Any) {
    }
    

}
extension ConfirmationCodeVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
