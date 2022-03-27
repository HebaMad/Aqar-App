//
//  NewAqarAdverstimentVC.swift
//  Aqar
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
    var packageNumber=0
    var aqar:Aqar?
    var status = "Add"
var id=0
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uploadBtn: UIButtonDesignable!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var adverstementType: UISegmentedControl!
    @IBOutlet weak var numOfGarage: UITextField!
    @IBOutlet weak var numOfBedroom: UITextField!
    @IBOutlet weak var numofBathrooms: UITextField!
    @IBOutlet weak var numofKitchen: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var titleTxt: UITextField!

    @IBOutlet weak var AddBtn: UIButtonDesignable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        if status == "Add"{
            titleLabel.text = "Add Aqar Adveristement"

        }else{
            titleLabel.text = "Edit Aqar Adveristement"
            editData()

        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        address.text = location
   

        
    }
    func editData(){
        guard let AqarData = aqar else { return  }
        priceTxt.text = "\(AqarData.price ?? 0)"
        numOfGarage.text = "\(AqarData.numberOfGarages ?? 0)"
        numOfBedroom.text = "\(AqarData.numberOfBedrooms ?? 0)"
        numofBathrooms.text = "\(AqarData.numberOfBathrooms ?? 0)"
        numofKitchen.text = "\(AqarData.numberOfKitchens ?? 0)"

        titleTxt.text = AqarData.title ?? ""
        location=AqarData.location ?? ""
        descriptionTxt.text=AqarData.description ?? ""
        guard let aqarImages = AqarData.images else{return}
        uploadBtn.setTitle("\(aqarImages.count)", for: .normal)
        for index in 0 ... aqarImages.count-1 {
            let data = NSData(contentsOf: URL(string: aqarImages[index]) ?? URL(fileURLWithPath: ""))
            imagesArray.append(data as! Data)
        }


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
                    
                    selectedImage=photo.originalImage.jpegData(compressionQuality: 0.3)
                    imagesArray.append(selectedImage ?? Data())
                    print("PHOTO", photo.originalImage,  imagesArray.count)
                    uploadBtn.setTitle("\(imagesArray.count) photos", for: .normal)

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
        
        let vc=MapVC.instantiate()
        vc.AdverstimentType = "aqar"
     navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func AddAqarBtn(_ sender: Any) {
        if AddBtn.title(for: .normal) == "Next"{
          
                let vc = AlertPackageVC.instantiate()
                vc.modalPresentationStyle = .overFullScreen
            vc.package=self
                present(vc, animated: true, completion: nil)
                
        }else{
        
        
        do{
        let title = try titleTxt.validatedText(validationType: .requiredField(field: "Title required"))
        let price = try priceTxt.validatedText(validationType: .requiredField(field: "price required"))
        let numKitchen = try numofKitchen.validatedText(validationType: .requiredField(field: "num of Kitchen required"))
        let numBathrooms = try numofBathrooms.validatedText(validationType: .requiredField(field: "num of Bathrooms required"))
  
        
        let numGarage = try numOfGarage.validatedText(validationType: .requiredField(field: "num Of Garage required"))
            let numBedroom = try numOfBedroom.validatedText(validationType: .requiredField(field: "num Of Bedroom required"))
            self.showLoading()
            if self.status == "Add"{
                AddAqar(NumberOfBedrooms: Int(numBedroom) ?? 0, NumberOfKitchens: Int(numKitchen) ?? 0, NumberOfBathrooms: Int(numBathrooms) ?? 0, NumberOfGarages: Int(numGarage) ?? 0, img: imagesArray, title: title, location: location, description: description, price: Int(price) ?? 0, advertismentType: adverstementType.selectedSegmentIndex+1, packageType: packageNumber, lat: lat, long: long)
            }else{
                updateAqar(id:id,NumberOfBedrooms: Int(numBedroom) ?? 0, NumberOfKitchens: Int(numKitchen) ?? 0, NumberOfBathrooms: Int(numBathrooms) ?? 0, NumberOfGarages: Int(numGarage) ?? 0, img: imagesArray, title: title, location: location, description: description, price: Int(price) ?? 0, advertismentType: adverstementType.selectedSegmentIndex+1, packageType: packageNumber, lat: lat, long: long)
            }
            
            

   
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
}
}
extension AddAqarAdverstimentVC{
    func AddAqar(NumberOfBedrooms:Int,NumberOfKitchens:Int,NumberOfBathrooms:Int,NumberOfGarages:Int,img:[Data],title:String,location:String,description:String,price:Int,advertismentType:Int,packageType:Int,lat:String,long:String){
        AqarManager.shared.AddAqar(Area: "1", NumberOfBedrooms: NumberOfBedrooms, NumberOfBathrooms: NumberOfBathrooms, NumberOfKitchens: NumberOfKitchens, NumberOfGarages: NumberOfGarages, imags: img, Title: title, Location: location, Description: description, Price: price, AdvertismentType: advertismentType, PackageType:packageType , Longitude: lat, Latitude: long) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.hideLoading()

                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
                    }
                    
                    
                    
                }
                
            case let .failure(error):
                self.hideLoading()

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
    }
    
    func updateAqar(id:Int,NumberOfBedrooms:Int,NumberOfKitchens:Int,NumberOfBathrooms:Int,NumberOfGarages:Int,img:[Data],title:String,location:String,description:String,price:Int,advertismentType:Int,packageType:Int,lat:String,long:String){
        AqarManager.shared.UpdateAqar(id:id,Area: "1", NumberOfBedrooms: NumberOfBedrooms, NumberOfBathrooms: NumberOfBathrooms, NumberOfKitchens: NumberOfKitchens, NumberOfGarages: NumberOfGarages, imags: img, Title: title, Location: location, Description: description, Price: price, AdvertismentType: advertismentType, PackageType:packageType , Longitude: lat, Latitude: long) { Response in
            switch Response{

            case let .success(response):
                if response.status == true{
                    self.hideLoading()
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
                    }
                    
                    
                    
                }
                
            case let .failure(error):
                self.hideLoading()

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
    }
    
    
}
extension AddAqarAdverstimentVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension AddAqarAdverstimentVC:packageType{
    func packageNum(packageType: Int) {
        packageNumber=packageType
        if packageNumber != 0 {
            if status == "Add"{
                AddBtn.setTitle("Add Aqar", for: .normal)

            }else{
                AddBtn.setTitle("Edit Aqar", for: .normal)

            }
        }else{
            AddBtn.setTitle("Next", for: .normal)

        }
    }
    
    
}
