//
//  ResetSuccessfullyVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ResetSuccessfullyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())
    }
    

}
extension ResetSuccessfullyVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
