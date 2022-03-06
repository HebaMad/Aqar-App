//
//  FirstOnBoardingVC.swift
//  Aqar
//
//  Created by heba isaa on 28/02/2022.
//

import UIKit

class FirstOnBoardingVC: UIViewController {

    @IBOutlet weak var onboardingImg: UIImageView!
    @IBOutlet weak var titleTxt: UILabel!
 
    @IBOutlet weak var discriptionText: UILabel!
    @IBOutlet weak var firstStep: UIButton!
    
    @IBOutlet weak var skipBtn: UIButtonDesignable!
    @IBOutlet weak var secondStep: UIButton!
    @IBOutlet weak var lastStep: UIButton!
    var numOfStep=1
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func skipAction(_ sender: Any) {
        
        if numOfStep == 1{
            secondOnboarding()
            numOfStep = 2
        }else if numOfStep == 2{
            skipBtn.setTitle("Get Started", for: .normal)

            thirdOnboarding()
            numOfStep = 3
        }else{
            self.sceneDelegate.setRootVC(vc: LoginChoicingVC.instantiate())
            
    }
    
    }
    @IBAction func view1(_ sender: Any) {
        firstOnboarding()
    }
    
    
    @IBAction func view2(_ sender: Any) {
        secondOnboarding()
    }
    
    @IBAction func view3(_ sender: Any) {
        thirdOnboarding()
    }
    
    
}

extension FirstOnBoardingVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}


extension FirstOnBoardingVC{
    
    func firstOnboarding(){
        numOfStep = 2
        firstStep.backgroundColor = UIColor(named: "buton")
        secondStep.backgroundColor = UIColor(named: "view")
        lastStep.backgroundColor = UIColor(named: "view")
        onboardingImg.image = UIImage(named: "Imageonboarding1")
        discriptionText.text = "Search and book the world’s largest collection of tours, attractions and experiences"
        titleTxt.text="your new Home"
    }
    func secondOnboarding(){
        firstStep.backgroundColor = UIColor(named: "view")
        secondStep.backgroundColor = UIColor(named: "buton")
        lastStep.backgroundColor = UIColor(named: "view")
        onboardingImg.image = UIImage(named: "onboarding2")
        discriptionText.text = "Search and book the world’s largest collection of tours, attractions and experiences"
        titleTxt.text="The Car you want"
        
    }
    func thirdOnboarding(){
        firstStep.backgroundColor = UIColor(named: "view")
        secondStep.backgroundColor = UIColor(named: "view")
        lastStep.backgroundColor = UIColor(named: "buton")
        onboardingImg.image = UIImage(named: "onboarding3")
        discriptionText.text = "Search and book the world’s largest collection of tours, attractions and experiences"
        titleTxt.text="Nice Places"
        numOfStep = 3
        skipBtn.setTitle("Get Started", for: .normal)

    }
    
}
