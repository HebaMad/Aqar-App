//
//  LoginChoicingVC.swift
//  Aqar
//
//  Created by heba isaa on 28/02/2022.
//

import UIKit

class LoginChoicingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func guestAction(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
    }
    
    @IBAction func userBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())
    }
    

}

extension LoginChoicingVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
