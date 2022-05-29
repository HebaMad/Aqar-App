//
//  NewCarAdverstimentVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit
import YPImagePicker


protocol packageType{
    func packageNum(packageType:Int)

}
class NewCarAdverstimentVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var selectedImage:Data?
    var packageNum:Int?
    var imagesArray:[Data]=[]
    var location=""
    var lat = ""
    var long = ""
   var packageNumber=0
    var car:Car?
    var status = "Add"
var id=0
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uploadBtn: UIButtonDesignable!
    @IBOutlet weak var AddBtn: UIButtonDesignable!
    @IBOutlet weak var titleTxt: UITextField!
    
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var adverstementType: UISegmentedControl!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var milesTxt: UITextField!
    @IBOutlet weak var speedTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var carModelText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        if status == "Add"{
            titleLabel.text = "Add Car Adveristement"

        }else{
            titleLabel.text = "Edit Car Adveristement"
            editData()

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        address.text = location
        
    }
    
    func editData(){
        guard let carData = car else { return  }
        priceTxt.text = "\(carData.price ?? 0)"
        milesTxt.text = "\(carData.miles ?? 0)"
        speedTxt.text = "\(carData.speed ?? 0)"
        titleTxt.text = carData.title ?? ""
        location=carData.location ?? ""
        descriptionTxt.text=carData.description ?? ""
        carModelText.text=carData.modelName ?? ""
        lat = "\(carData.latitude ?? 0.0)"
        long = "\(carData.longitude ?? 0.0)"
        
        
        
        
        guard let carImages = carData.images else{return}
            uploadBtn.setTitle("\(carImages.count)", for: .normal)
        if carImages.count != 0 {

        for index in 0 ... carImages.count-1 {
            let data = NSData(contentsOf: URL(string: carImages[index]) ?? URL(fileURLWithPath: ""))
            imagesArray.append(data as! Data)
        }


        }else{
            
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
        
        if AddBtn.title(for: .normal) == "Next"{
          
                let vc = AlertPackageVC.instantiate()
                vc.modalPresentationStyle = .overFullScreen
            vc.package=self
                present(vc, animated: true, completion: nil)
                
        }else{
          
        
        do{
        let title = try titleTxt.validatedText(validationType: .requiredField(field: "Title required"))
        let price = try priceTxt.validatedText(validationType: .requiredField(field: "price required"))
        let mile = try milesTxt.validatedText(validationType: .requiredField(field: "miles required"))
        let speed = try speedTxt.validatedText(validationType: .requiredField(field: "speed required"))
   
        
        let carmodel = try carModelText.validatedText(validationType: .requiredField(field: "car model required"))
            self.showLoading()
            if self.status == "Add"{
        AddCar(modelName: carmodel, miles: Int(mile) ?? 0, speed: Int(speed) ?? 0, img: imagesArray, title: title, location: location, description: descriptionTxt.text ?? "", price: Int(price) ?? 0, advertismentType: adverstementType.selectedSegmentIndex+1, packageType: packageNumber, lat: lat, long: long)
            }else{
                print(imagesArray.count)
                EditCar(id:id,modelName: carmodel, miles: Int(mile) ?? 0, speed: Int(speed) ?? 0, img: imagesArray, title: title, location: location, description: descriptionTxt.text ?? "", price: Int(price) ?? 0, advertismentType: adverstementType.selectedSegmentIndex+1, packageType: packageNumber, lat: lat, long: long)
            }
            
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
        internetConnectionChecker { (status) in
            if status{
                
        CarManager.shared.AddCar(ModelName: modelName, Miles: miles, Speed: speed, imags: img, Title: title, Location: location, Description: description, Price: price, AdvertismentType: advertismentType, PackageType: packageType, Longitude: long, Latitude: lat) { Response in
            self.hideLoading()

            switch Response{

         
            case let .success(response):
                if response.status == true{

            
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
                    }
                    
                    
                    
                }
                
            case let .failure(error):

                self.showAlert(title:  "Notice", message: "something eroro", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
            
        }
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
    func EditCar(id:Int,modelName:String,miles:Int,speed:Int,img:[Data],title:String,location:String,description:String,price:Int,advertismentType:Int,packageType:Int,lat:String,long:String){
        self.hideLoading()

        internetConnectionChecker { (status) in
            if status{
                
        CarManager.shared.updateCar(id:id,ModelName: modelName, Miles: miles, Speed: speed, imags: img, Title: title, Location: location, Description: description, Price: price, AdvertismentType: advertismentType, PackageType: packageType, Longitude: long, Latitude: lat) { Response in
            
            switch Response{

                
            case let .success(response):
                if response.status == true{

                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.sceneDelegate.setRootVC(vc: carAqarTabBarController.instantiate())
                    }
                    
                    
                    
                }
                
            case let .failure(error):

                self.showAlert(title:  "Notice", message: "something eroro", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
            
        }
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
}

extension NewCarAdverstimentVC:packageType{
    func packageNum(packageType: Int) {
        packageNumber=packageType
        if packageNumber != 0 {
            if status == "Add"{
                AddBtn.setTitle("Add car", for: .normal)

            }else{
                AddBtn.setTitle("Edit car", for: .normal)

            }
        }else{
            AddBtn.setTitle("Next", for: .normal)

        }
    }
    
    
}
