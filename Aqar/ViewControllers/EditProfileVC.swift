//
//  EditProfileVC.swift
//  Aqar
//
//  Created by heba isaa on 06/03/2022.
//

import UIKit
import SDWebImage
class EditProfileVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var selectedImage:Data?
    var userData:ProfileModel?
    @IBOutlet weak var profileImg: UIImageViewDesignable!
    @IBOutlet weak var fullNameTxt: UITextField!
    
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    func setupData(){
        profileImg.sd_setImage(with: URL(string:userData?.image ?? "" ))
        fullNameTxt.text = userData?.fullName ?? ""
        countryTxt.text = userData?.country ?? ""
        phoneNum.text = userData?.phoneNumber ?? ""
        emailTxt.text = userData?.email ?? ""

    }

    @IBAction func changePassword(_ sender: Any) {
        let vc = ForgettenPasswordVC.instantiate()
        vc.status = "edit"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func selectPhotoBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return  }
        print(image)
        profileImg.image=image
        selectedImage=image.jpegData(compressionQuality: 0.5)
     
        
    }
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
 
    @IBAction func editBtn(_ sender: Any) {
      let pic = selectedImage ?? Data()
        print(pic.description)
        if pic.isEmpty == false{
            
        
        do{
            
            let email = try emailTxt.validatedText(validationType: .email)
            let username = try fullNameTxt.validatedText(validationType: .username)
            let phonenum = try phoneNum.validatedText(validationType: .requiredField(field: "phone required"))
            let country = try countryTxt.validatedText(validationType: .requiredField(field: "country required"))
            
            self.showLoading()
            editProfile(email: email, country: country, phoneNum: phonenum, fullname: username, img: pic)
         
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
        }else{
            self.showAlert(title:  "Notice", message: "profile image required", confirmBtnTitle: "OK", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
        }
        }
    }
    
}
extension EditProfileVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension EditProfileVC{
    func editProfile(email:String,country:String,phoneNum:String,fullname:String,img:Data){
        internetConnectionChecker { (status) in
            if status{
                
        ProfileManager.shared.updateProfile(FullName: fullname, Country: country, PhoneNumber: phoneNum, Email: email, img: img) { Response in
            switch Response{
               
                
            case let .success(response):
                self.hideLoading()

                if response.status == true {
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "OK", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.navigationController?.popViewController(animated: true)
                }
                }else{
                    self.showAlert(title:  "Error", message: response.message, confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
                }
            case let .failure(error):
                self.hideLoading()

                self.showAlert(title:  "Notice", message: "something error", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
                
                
            }
        }
        
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
}
