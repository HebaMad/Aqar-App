//
//  AlertPackageVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit

class AlertPackageVC: UIViewController {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var packageDetailsTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
     
    }
    
    @IBAction func bronzePackage(_ sender: Any) {
    }
    @IBAction func silverPackage(_ sender: Any) {
    }
    
    @IBAction func goldenPackage(_ sender: Any) {
    }
}
extension AlertPackageVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

