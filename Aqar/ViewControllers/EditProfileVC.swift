//
//  EditProfileVC.swift
//  Aqar
//
//  Created by heba isaa on 06/03/2022.
//

import UIKit

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var selectedImage:Data?
    
    @IBOutlet weak var profileImg: UIImageViewDesignable!
    @IBOutlet weak var fullNameTxt: UITextField!
    
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        do{
            
            let email = try emailTxt.validatedText(validationType: .email)
            let username = try fullNameTxt.validatedText(validationType: .username)
            let phonenum = try phoneNum.validatedText(validationType: .phoneNumber)
            let country = try countryTxt.validatedText(validationType: .requiredField(field: "country required"))
            editProfile(email: email, country: country, phoneNum: phonenum, fullname: username, img: selectedImage ?? Data())
         
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
    
}
extension EditProfileVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension EditProfileVC{
    func editProfile(email:String,country:String,phoneNum:String,fullname:String,img:Data){
        
        ProfileManager.shared.updateProfile(FullName: fullname, Country: country, PhoneNumber: phoneNum, Email: email, img: img) { Response in
            switch Response{
                
                
            case let .success(response):
                
                if response.status == true {
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "OK", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
                }else{
                    self.showAlert(title:  "Error", message: response.message, confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
                }
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
                
                
            }
        }
        
    }
}
