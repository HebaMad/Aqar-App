//
//  AboutUsVC.swift
//  Aqar
//
//  Created by heba isaa on 02/03/2022.
//

import UIKit

class AboutUsVC: UIViewController {
var aboutusTxt=""
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var aboutUsText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutUsText.text = aboutusTxt
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
dismiss(animated: true, completion: nil)
        
    }
 

}
extension AboutUsVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

