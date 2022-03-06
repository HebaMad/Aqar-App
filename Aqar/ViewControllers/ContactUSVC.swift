//
//  ContactUSVC.swift
//  Aqar
//
//  Created by heba isaa on 02/03/2022.
//

import UIKit

class ContactUSVC: UIViewController {

    @IBOutlet var tapGes: UITapGestureRecognizer!
    @IBOutlet weak var contactDetails: UILabel!
    @IBOutlet weak var contactNumber: UIButtonDesignable!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tapGes.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func phoneCall(_ sender: Any) {
    }
    
 

}
extension ContactUSVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

