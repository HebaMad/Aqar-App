//
//  NewCarAdverstimentVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit
import YPImagePicker
class NewCarAdverstimentVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var selectedImage:Data?
    var packageNum:Int?
    var imagesArray:[Data]=[]
    var location=""
    var lat = ""
    var long = ""
    
    @IBOutlet weak var uploadBtn: UIButtonDesignable!
    @IBOutlet weak var AddBtn: UIButtonDesignable!
    @IBOutlet weak var titleTxt: UITextField!
    
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var adverstementType: UISegmentedControl!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var milesTxt: UITextField!
    @IBOutlet weak var speedTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var carModelText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        vc.AdverstimentType = "car"
     navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func AddCarBtn(_ sender: Any) {
        
        if AddBtn.title(for: .normal) == "next"{
          
                let vc = AlertPackageVC.instantiate()
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
                
        }else{
        
        
        do{
        let title = try titleTxt.validatedText(validationType: .requiredField(field: "Title required"))
        let price = try priceTxt.validatedText(validationType: .requiredField(field: "price required"))
        let mile = try milesTxt.validatedText(validationType: .requiredField(field: "miles required"))
        let speed = try speedTxt.validatedText(validationType: .requiredField(field: "speed required"))
        let description = try descriptionTxt.validatedText(validationType: .requiredField(field: "description required"))
        
        let carmodel = try carModelText.validatedText(validationType: .requiredField(field: "car model required"))
            
        AddCar(modelName: carmodel, miles: Int(mile) ?? 0, speed: Int(speed) ?? 0, img: imagesArray, title: title, location: location, description: description, price: Int(price) ?? 0, advertismentType: adverstementType.selectedSegmentIndex+1, packageType: 1, lat: lat, long: long)
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
}
}
extension NewCarAdverstimentVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension NewCarAdverstimentVC{
    
    func AddCar(modelName:String,miles:Int,speed:Int,img:[Data],title:String,location:String,description:String,price:Int,advertismentType:Int,packageType:Int,lat:String,long:String){
        CarManager.shared.AddCar(ModelName: modelName, Miles: miles, Speed: speed, imags: img, Title: title, Location: location, Description: description, Price: price, AdvertismentType: advertismentType, PackageType: packageType, Longitude: long, Latitude: lat) { Response in
            
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
