//
//  MapVC.swift
//  Rakwa
//
//  Created by heba isaa on 25/11/2021.
//

import UIKit
import MapKit
class MapVC: UIViewController {
var AdverstimentType="car"
    @IBOutlet weak var mapView: MKMapView!
    let locationmanager:LocationManager? = nil
    let regionInMeters: Double = 10000
    var screen="classified"
    var lat=""
    var long=""
var Fulladdress = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        setupLocation()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          
          // mapView is the outlet of map
          mapView.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButton(_ sender: Any) {
        for viewController: UIViewController in (self.navigationController?.viewControllers)!{
            if AdverstimentType == "car"{
                if (viewController is NewCarAdverstimentVC){

                    let vc: NewCarAdverstimentVC = (viewController as? NewCarAdverstimentVC)!
                    vc.location=Fulladdress
                    vc.lat=lat
                    vc.long=long
                      self.navigationController?.popToViewController(vc, animated: true)
                }
            }else{
                
                if (viewController is AddAqarAdverstimentVC){

                    let vc: AddAqarAdverstimentVC = (viewController as? AddAqarAdverstimentVC)!
                    vc.location=Fulladdress
                    vc.lat=lat
                    vc.long=long
                    self.navigationController?.popToViewController(vc, animated: true)
            }
        
    }
           
  


        }
    
    
    }
            
    func setupLocation(){
        
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in

                    if let error = error {
                        return
                    }
            guard let location = location else {
                        self.showAlert(title: "Location Permission Required", message: "You should activate your location ", confirmBtnTitle: "OK", cancelBtnTitle: "", hideCancelBtn: true) { (action) in
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        }
                        return
                    }
            
            LocationManager.shared.getAddressFromLatLon(pdblLatitude: "\(location.coordinate.latitude)", withLongitude: "\(location.coordinate.longitude)", callback: { status,addresses,country   in
                if status{
                    self.Fulladdress=addresses ?? "no clear address"
                }
            })
            let lat: Double = Double("\(location.coordinate.latitude)")!
            let lon: Double = Double("\(location.coordinate.longitude)")!
            self.lat = "\(lat)"
            self.long = "\(lon)"

            let center = CLLocationCoordinate2DMake(lat, lon)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                               let region = MKCoordinateRegion(center: center, span: span)
                               self.mapView.setRegion(region, animated: true)
                               let annotation = MKPointAnnotation()
                               annotation.coordinate = center
            
//                               if let email = self.userEmail{
//                                   annotation.title = email
//                               }

                               self.mapView.addAnnotation(annotation)
            
            
//            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: self.regionInMeters, longitudinalMeters: self.regionInMeters)
//            self.mapView.setRegion(region, animated: true)
//                    print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
//
//
            
            do{
                
//                self.home(levelid: 1, lat:"\( location.coordinate.latitude)", long: "\(location.coordinate.longitude)")
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }
                }
        
        
//        guard let loc = locationmanager else {return}
//
//     if   LocationManager.shared.isLocationEnabled(){
//         mapView.showsUserLocation=true
//         loc.getCurrentReverseGeoCodedLocation { location, placemark, error in
//             let region = MKCoordinateRegion.init(center: location!.coordinate, latitudinalMeters: self.regionInMeters, longitudinalMeters: self.regionInMeters)
//             self.mapView.setRegion(region, animated: true)
//         }
//        }
        
        }
    
    
    
    @objc func handleTap(gestureReconizer: UITapGestureRecognizer) {
            
            let location = gestureReconizer.location(in: mapView)
      
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        LocationManager.shared.getAddressFromLatLon(pdblLatitude: "\(coordinate.latitude)", withLongitude: "\(coordinate.longitude)", callback: { status,addresses,country   in
            if status{
                self.Fulladdress=addresses ?? "no clear address"
            }
        })
      
        
        print(Fulladdress)
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            print(" Coordinates ======= \(coordinate)")
    lat = "\(coordinate.latitude)"
        long="\(coordinate.longitude)"
            
            /* to show only one pin while tapping on map by removing the last.
            If you want to show multiple pins you can remove this piece of code */
            if mapView.annotations.count == 1 {
                mapView.removeAnnotation(mapView.annotations.last!)
            }
            mapView.addAnnotation(annotation) // add annotaion pin on the map
        }
      
        }
extension MapVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}




   

