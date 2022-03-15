//
//  AddAdverstimentType.swift
//  Aqar
//
//  Created by heba isaa on 15/03/2022.
//

import UIKit

class AddAdverstimentType: UIViewController {
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
           dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func AddCarBtn(_ sender: Any) {
        
        navigationController?.pushViewController(NewCarAdverstimentVC.instantiate(), animated: true)
    }
    

    @IBAction func addAqarBtn(_ sender: Any) {
        
        navigationController?.pushViewController(AddAqarAdverstimentVC.instantiate(), animated: true)
        
    }
    
}
extension AddAdverstimentType:Storyboarded{
    
    static var storyboardName: StoryboardName = .main
    
}
