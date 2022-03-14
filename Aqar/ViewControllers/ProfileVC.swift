//
//  ProfileVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ProfileVC: UIViewController {
    var aboutUsText=""
    var contactUsText=""

    var profileItem:[Menu]=[]
    
    @IBOutlet weak var bronzeAdsTxt: UILabel!
    @IBOutlet weak var silverAdsTxt: UILabel!
    @IBOutlet weak var goldenAdsTxt: UILabel!
    @IBOutlet weak var countryTxt: UILabel!
    @IBOutlet weak var mobileNumTxt: UILabel!
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var menuTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        getUserData()
        contactUsData()
        aboutus()
    }
    
    func setupData(){
        menuTable.register(MenuCell.self)
        profileItem=Menu.menuItem
        menuTable.delegate=self
        menuTable.dataSource=self
    }

}
extension ProfileVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuCell = tableView.dequeueReusableCell(for: indexPath)
        cell.menuTxt.text = profileItem[indexPath.row].menuText
        cell.menuImg.image = profileItem[indexPath.row].menuImg
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0 :
            navigationController?.pushViewController(NewCarAdverstimentVC.instantiate(), animated: true)
        case 1:
        
            navigationController?.pushViewController(EditProfileVC.instantiate(), animated: true)

        case 2:
        let vc = ContactUSVC.instantiate()
            vc.modalPresentationStyle = .overFullScreen
            vc.contactUS=contactUsText
            present(vc, animated: true, completion: nil)
        case 3:
            let vc = AboutUsVC.instantiate()
                vc.modalPresentationStyle = .overFullScreen
            vc.aboutusTxt = aboutUsText
            present(vc, animated: true, completion: nil)
        case 4:
            let vc = LogoutAlertVC.instantiate()
                vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
 
        default:
           
print("error")
        }
    
    
    
}
}


extension ProfileVC{
    
    func contactUsData(){
        SettingManager.shared.contactUs { Response in
            switch Response{
                
            case let .success(response):
                
                if response.status == true {
                    guard let responseData = response.data else {return}
                    self.contactUsText=responseData.value ?? ""
                }
                
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
    }
    
    func aboutus(){
        SettingManager.shared.aboutus { Response in
            switch Response{
                
            case let .success(response):
                
                if response.status == true {
                    guard let responseData = response.data else {return}
                    self.aboutUsText=responseData.value ?? ""
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
                
                
            }
        }
    }
    
    
    func getUserData(){
        ProfileManager.shared.profileDetails { Response in
            
            switch Response{
                
            case let .success(response):
                
                if response.status == true {
                    guard let responsedata = response.data else {return}
                    self.countryTxt.text=responsedata.country ?? ""
                    self.mobileNumTxt.text=responsedata.phoneNumber ?? ""
                    self.usernameTxt.text=responsedata.fullName ?? ""

                    self.bronzeAdsTxt.text=String(describing:responsedata.bronzeAdsCount ?? 0)
                    self.silverAdsTxt.text=String(describing:responsedata.silverAdsCount ?? 0)
                    self.goldenAdsTxt.text=String(describing:responsedata.goldenAdsCount ?? 0)
                }
                
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
            
            
            
        }
    }
}
