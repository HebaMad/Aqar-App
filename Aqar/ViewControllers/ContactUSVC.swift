//
//  ContactUSVC.swift
//  Aqar
//  Created by heba isaa on 02/03/2022.

import UIKit

class ContactUSVC: UIViewController {
    var contactUS=""
var phone=""
    @IBOutlet var tapGes: UITapGestureRecognizer!
    @IBOutlet weak var contactDetails: UILabel!
    @IBOutlet weak var contactNumber: UIButtonDesignable!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactDetails.text = contactUS
        contactNumber.setTitle("\(phone)", for: .normal)
    
        tapGes.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func phoneCall(_ sender: Any) {
        
        self.callMobile(mobileNum: phone)
    }
    
 

}
extension ContactUSVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}


