//
//  DetailsVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit

class DetailsVC: UIViewController {
var stateType="car"
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var addressTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var backgroundImg: UIImageViewDesignable!
    
    
    var carDetails:Car?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if stateType == "car"{
            carData()
        }else{
            
        }

    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func callBtn(_ sender: Any) {
//        self.callMobile(mobileNum: carDetails.p)
    }
    
    @IBAction func emailBtn(_ sender: Any) {
//        self.sendEmail(email: "")
    }
    
}
extension DetailsVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension DetailsVC{
    
    func carData(){
        descriptionTxt.text = carDetails?.description
        addressTxt.text = carDetails?.location
        titleTxt.text = carDetails?.title

    }
    
    
    
}
