//
//  FilterVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class CarFilterVC: UIViewController {

    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var milesTxt: UITextField!
    @IBOutlet weak var speedTxt: UITextField!
    @IBOutlet weak var adverstimentTypeSegment: UISegmentedControl!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))
        

    }
  
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        do{
        let mile = try milesTxt.validatedText(validationType: .requiredField(field: "miles required"))
        let speed = try speedTxt.validatedText(validationType: .requiredField(field: "speed required"))
      }catch(let error){
        self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
    }
    }
}
extension CarFilterVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
