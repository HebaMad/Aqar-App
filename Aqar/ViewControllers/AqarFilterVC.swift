//
//  AqarFilterVC.swift
//  Aqar
//
//  Created by heba isaa on 28/03/2022.
//

import UIKit
import RangeSeekSlider
class AqarFilterVC: UIViewController {
    var minvalue:Float=0.0
    var maxvalue:Float=0.0
    var page=0
    var aqar:aqarData?
var delegate:filteringAqarData?
    
    
    @IBOutlet weak var adverstimentTypeSegment: UISegmentedControl!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var priceSlidering: RangeSeekSlider!
    @IBOutlet weak var kitchenTxt: UITextField!
    @IBOutlet weak var garageTxt: UITextField!
    
    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var areaTxt: UITextField!
    @IBOutlet weak var bedTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))
        priceSlidering.numberFormatter.positivePrefix = "$"
        priceSlidering.numberFormatter.positiveSuffix = "$"
        
        
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
            
            aqar=aqarData(numberOfBedrooms: Int(numBedroom) ?? 0, numberOfKitchens: Int(numKitchen) ?? 0, numberOfGarages: Int(numGarage) ?? 0, advertismentType: self.dateSegment.selectedSegmentIndex+1, priceFrom: self.minvalue, priceTo: self.maxvalue, area: Int(area) ?? 0, date: self.adverstimentTypeSegment.selectedSegmentIndex+1)
            
            guard let _delegate=self.delegate else {return}
            self.dismiss(animated: true) {
                guard let aqar = self.aqar else { return  }
                _delegate.filtering(data:aqar )
            }
            
//
           
            
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
    
}
extension AqarFilterVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension AqarFilterVC:RangeSeekSliderDelegate{
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        minvalue=Float(minValue)
        maxvalue=Float(maxValue)
    }
}



