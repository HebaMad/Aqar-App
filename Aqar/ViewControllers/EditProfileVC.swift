//
//  EditProfileVC.swift
//  Aqar
//
//  Created by heba isaa on 06/03/2022.
//

import UIKit

class EditProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
 

}
extension EditProfileVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
