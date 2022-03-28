//
//  AlertPackageVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit

class AlertPackageVC: UIViewController {

    @IBOutlet weak var bronzeView: UIViewDesignable!
    @IBOutlet weak var goldenView: UIViewDesignable!
    @IBOutlet weak var silverView: UIViewDesignable!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var packageDetailsTxt: UILabel!
    var package:packageType?
    var packageNum=0
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))


    }
  

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        
           self.dismiss(animated: true) {
               if let _delegate = self.package{
                   _delegate.packageNum(packageType: self.packageNum)
               }}
     
    }
    
    @IBAction func bronzePackage(_ sender: Any) {
        package(packageNym: 1)
        
    }
    @IBAction func silverPackage(_ sender: Any) {
        package(packageNym: 2)

    }
    
    @IBAction func goldenPackage(_ sender: Any) {
        package(packageNym: 3)
        
    }
}
extension AlertPackageVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension AlertPackageVC{
    
    func package(packageNym:Int){
        switch packageNym{
        case 1 :
            bronzeView.backgroundColor = .white
            goldenView.backgroundColor = UIColor(named: "Ticket")
            silverView.backgroundColor = UIColor(named: "Ticket")
            packageNum=1

        case 2:
            packageNum=2
            silverView.backgroundColor = .white
            goldenView.backgroundColor = UIColor(named: "Ticket")
            bronzeView.backgroundColor = UIColor(named: "Ticket")
        case 3:
            packageNum=3
            goldenView.backgroundColor = .white
            silverView.backgroundColor = UIColor(named: "Ticket")
            bronzeView.backgroundColor = UIColor(named: "Ticket")
        default:
            print("Error")
        }
    }
}

