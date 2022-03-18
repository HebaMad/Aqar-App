//
//  AddAdverstimentType.swift
//  Aqar
//
//  Created by heba isaa on 15/03/2022.
//

import UIKit

class AddAdverstimentType: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addCar(_ sender: Any) {
        navigationController?.pushViewController(NewCarAdverstimentVC.instantiate(), animated: true)
    }
    
    @IBAction func addAqar(_ sender: Any) {
        navigationController?.pushViewController(AddAqarAdverstimentVC.instantiate(), animated: true)

    }
    
    
}
extension AddAdverstimentType:Storyboarded{
    
    static var storyboardName: StoryboardName = .main
    
}
