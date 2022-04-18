//
//  DetailsVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit
import MapKit

import SDWebImage
class DetailsVC: UIViewController {
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

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
    @IBOutlet weak var mapView: MKMapView!

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
    func captureScreen(_ viewcapture : UIView) -> UIImage {

          UIGraphicsBeginImageContextWithOptions(viewcapture.frame.size, viewcapture.isOpaque, 0.0)
          viewcapture.layer.render(in: UIGraphicsGetCurrentContext()!)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return image!;
      }
    
    
}
extension DetailsVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension DetailsVC{
    
    func realStatedetails(){
        if stateType == "car"{
            getAddress(lat: "\(carDetails?.latitude ?? 0.0)", long: "\(carDetails?.latitude ?? 0.0)")
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
            getAddress(lat: "\(aqarDetails?.latitude ?? 0.0)", long: "\(aqarDetails?.longitude ?? 0.0)")
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
    
    
    func getAddress(lat:String,long:String){

  
        let lat: Double = Double("\(lat)") ?? 0.0
        let lon: Double = Double("\(long)") ?? 0.0
            let center = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
                               let region = MKCoordinateRegion(center: center, span: span)
//                               self.mapView.setRegion(region, animated: true)
                               let annotation = MKPointAnnotation()
                               annotation.coordinate = center
                               self.mapView.addAnnotation(annotation)

    
    }
    
}
extension DetailsVC:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"

        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        if let annotationView = annotationView {
            // Configure your annotation view here
            // view for annotation
            let viewAn = UIView()
            viewAn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            // label as required
//            let lbl = UILabel()
//            lbl.text = "ABC 123"
//            lbl.textColor = UIColor.black
//            lbl.backgroundColor = UIColor.cyan
//            // add label to viewAn
//            lbl.frame = viewAn.bounds
//            viewAn.addSubview(lbl)
            // capture viewAn
            let img = self.captureScreen(viewAn)

            annotationView.canShowCallout = true
            // set marker
            annotationView.image = UIImage(named: "marker")
        }

        return annotationView
      }
}
