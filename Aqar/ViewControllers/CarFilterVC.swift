//
//  FilterVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit
import RangeSeekSlider
class CarFilterVC: UIViewController {
    var delegate:filteringCarData?
    var car:carFilteringData?
    var minvalue:Float=0.0
    var maxvalue:Float=0.0
    @IBOutlet weak var priceSlidering: RangeSeekSlider!

    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var milesTxt: UITextField!
    @IBOutlet weak var speedTxt: UITextField!
    @IBOutlet weak var adverstimentTypeSegment: UISegmentedControl!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.addTarget(self, action: #selector(self.handleTap(_:)))
        priceSlidering.numberFormatter.positivePrefix = "$"
        priceSlidering.numberFormatter.positiveSuffix = "$"
        priceSlidering.delegate = self

    }
  
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        do{
        let mile = try milesTxt.validatedText(validationType: .requiredField(field: "miles required"))
        let speed = try speedTxt.validatedText(validationType: .requiredField(field: "speed required"))
            
            car=carFilteringData(speed: Int(speed) ?? 0, miles: Int(mile) ?? 0, advertismentType: self.dateSegment.selectedSegmentIndex+1, priceFrom: self.minvalue, priceTo: self.maxvalue, date: self.adverstimentTypeSegment.selectedSegmentIndex)
            
            guard let _delegate=self.delegate else {return}
            self.dismiss(animated: true) {
                guard let carData = self.car else { return  }
                _delegate.filtering(data:carData )
            }
            
            
      }catch(let error){
        self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
    }
    }
}
extension CarFilterVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension CarFilterVC:RangeSeekSliderDelegate{
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        minvalue=Float(minValue)
        maxvalue=Float(maxValue)
    }
}
