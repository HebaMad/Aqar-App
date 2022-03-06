//
//  LogoutAlertVC.swift
//  Aqar
//
//  Created by heba isaa on 02/03/2022.
//

import UIKit

class LogoutAlertVC: UIViewController {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
dismiss(animated: true, completion: nil)
        
    }
 
    @IBAction func yesBtn(_ sender: Any) {
    }
    @IBAction func noBtn(_ sender: Any) {
    }
    
}
extension LogoutAlertVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
