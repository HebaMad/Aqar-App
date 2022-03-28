//
//  AqarFilterVC.swift
//  Aqar
//
//  Created by heba isaa on 28/03/2022.
//

import UIKit

class AqarFilterVC: UIViewController {
    
    @IBOutlet weak var adverstimentTypeSegment: UISegmentedControl!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var kitchenTxt: UITextField!
    @IBOutlet weak var garageTxt: UITextField!
    
    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var areaTxt: UITextField!
    @IBOutlet weak var bedTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        do{
            let numKitchen = try kitchenTxt.validatedText(validationType: .requiredField(field: "num of Kitchen required"))
            
            let numGarage = try garageTxt.validatedText(validationType: .requiredField(field: "num Of Garage required"))
            let numBedroom = try bedTxt.validatedText(validationType: .requiredField(field: "num Of Bedroom required"))
            
            let area = try areaTxt.validatedText(validationType: .requiredField(field: "area required"))
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
    
}
extension AqarFilterVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
