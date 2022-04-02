//
//  DetailsVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit
import SDWebImage
class DetailsVC: UIViewController {
    var stateType="car"
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var addressTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var photoNumBtn: UIButtonDesignable!
    @IBOutlet weak var backgroundImg: UIImageViewDesignable!
    
    @IBOutlet weak var RoomsNumView: UIView!
    @IBOutlet weak var kitchenNum: UILabel!
    @IBOutlet weak var bathroomNum: UILabel!
    @IBOutlet weak var carageNum: UILabel!
    @IBOutlet weak var bedroomNum: UILabel!
    
    @IBOutlet weak var adverstimentType: UILabel!
    
    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var areaTxt: UILabel!
    var aqarDetails:Aqar?
    var carDetails:Car?
    override func viewDidLoad() {
        super.viewDidLoad()
        realStatedetails()
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func callBtn(_ sender: Any) {
            
            self.callMobile(mobileNum: carDetails?.userPhone ?? "")
    }
    
    @IBAction func messageBtn(_ sender: Any) {
        
        self.callWhatsapp(phoneNum: carDetails?.userPhone ?? "")
        
        
    }
    
    @IBAction func emailBtn(_ sender: Any) {
            
            self.sendEmail(email: carDetails?.userEmail ?? "")
       
    }
    
    @IBAction func realStatePhotos(_ sender: Any) {
        let vc=PhotosVC.instantiate()
        if stateType == "car"{
            
            vc.realStatePhotos=carDetails?.images ?? []
            
            
        }else{
            
            vc.realStatePhotos=aqarDetails?.images ?? []
            
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension DetailsVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension DetailsVC{
    
    func realStatedetails(){
        if stateType == "car"{
            
            descriptionTxt.text = carDetails?.description
            addressTxt.text = carDetails?.location
            titleTxt.text = carDetails?.title
            photoNumBtn.setTitle("1to\(carDetails?.images?.count ?? 0)", for: .normal)
            RoomsNumView.isHidden = true
            separatorLine.isHidden = true
            backgroundImg.sd_setImage(with: URL(string:carDetails?.mainImage ?? "" ))
            if carDetails?.advertismentType == 1{
                adverstimentType.text = "Rent"
            }else{
                adverstimentType.text = "Purchase"

            }
        }else{
            
            descriptionTxt.text = aqarDetails?.description
            addressTxt.text = aqarDetails?.location
            titleTxt.text = aqarDetails?.title
            photoNumBtn.setTitle("1to\(aqarDetails?.images?.count ?? 0)", for: .normal)
            RoomsNumView.isHidden = false
            kitchenNum.text=String(describing: aqarDetails?.numberOfKitchens ?? 0)
            bathroomNum.text=String(describing:aqarDetails?.numberOfBathrooms ?? 0)
            carageNum.text=String(describing: aqarDetails?.numberOfGarages ?? 0)
            bedroomNum.text = String(describing: aqarDetails?.numberOfBedrooms ?? 0)
            
            backgroundImg.sd_setImage(with: URL(string:aqarDetails?.mainImage ?? "" ))
            if aqarDetails?.advertismentType == 1{
                adverstimentType.text = "Rent"
            }else{
                adverstimentType.text = "Purchase"

            }
            areaTxt.text="\(aqarDetails?.area ?? 0)"
        }
        
    }
    
}
