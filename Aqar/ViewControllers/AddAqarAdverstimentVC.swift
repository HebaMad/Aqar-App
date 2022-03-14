//
//  NewAqarAdverstimentVC.swift
//  Aqar
//
//  Created by heba isaa on 14/03/2022.
//

import UIKit
import YPImagePicker
class AddAqarAdverstimentVC: UIViewController {
    var selectedImage:Data?

    var imagesArray:[Data]=[]
    var location=""
    var lat = ""
    var long = ""
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var adverstementType: UISegmentedControl!
    @IBOutlet weak var numOfGarage: UITextField!
    @IBOutlet weak var numOfBedroom: UITextField!
    @IBOutlet weak var numofBathrooms: UITextField!
    @IBOutlet weak var numofKitchen: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var titleTxt: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        address.text = location
        
    }

    @IBAction func uploadCarPhotoBtn(_ sender: Any) {
        self.imagesArray=[]
        
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 20
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [self, unowned picker] items, cancelled in
            
            for item in items {
                
                       switch item {
                    
                case .photo(let photo):
                    
                    selectedImage=photo.originalImage.jpegData(compressionQuality: 0.5)
                    imagesArray.append(selectedImage ?? Data())
                    print("PHOTO", photo.originalImage,  imagesArray.count)
                    
                case .video(let video):
                    print(video)
                    
                  }
                
            }
            
            
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectLocation(_ sender: Any) {
        
     navigationController?.pushViewController(MapVC.instantiate(), animated: true)
        
    }
    

    @IBAction func AddAqarBtn(_ sender: Any) {
        do{
        let title = try titleTxt.validatedText(validationType: .requiredField(field: "Title required"))
        let price = try priceTxt.validatedText(validationType: .requiredField(field: "price required"))
        let numKitchen = try numofKitchen.validatedText(validationType: .requiredField(field: "num of Kitchen required"))
        let numBathrooms = try numofBathrooms.validatedText(validationType: .requiredField(field: "num of Bathrooms required"))
  
        
        let numGarage = try numOfGarage.validatedText(validationType: .requiredField(field: "num Of Garagerequired"))
            let numBedroom = try numOfBedroom.validatedText(validationType: .requiredField(field: "num Of Bedroom required"))
AddAqar(NumberOfBedrooms: Int(numBedroom) ?? 0, NumberOfKitchens: Int(numKitchen) ?? 0, NumberOfBathrooms: Int(numBathrooms) ?? 0, NumberOfGarages: Int(numGarage) ?? 0, img: imagesArray, title: title, location: location, description: description, price: Int(price) ?? 0, advertismentType: adverstementType.selectedSegmentIndex+1, packageType: 1, lat: lat, long: long)
   
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
}

extension AddAqarAdverstimentVC{
    func AddAqar(NumberOfBedrooms:Int,NumberOfKitchens:Int,NumberOfBathrooms:Int,NumberOfGarages:Int,img:[Data],title:String,location:String,description:String,price:Int,advertismentType:Int,packageType:Int,lat:String,long:String){
        AqarManager.shared.AddAqar(Area: "1", NumberOfBedrooms: NumberOfBedrooms, NumberOfBathrooms: NumberOfBathrooms, NumberOfKitchens: NumberOfKitchens, NumberOfGarages: NumberOfGarages, imags: img, Title: title, Location: location, Description: description, Price: price, AdvertismentType: advertismentType, PackageType: 1, Longitude: lat, Latitude: long) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
            
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
                    }
                    
                    
                    
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
    }
}
