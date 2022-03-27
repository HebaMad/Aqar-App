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
    var car:[Car]=[]
    var Aqar:[Aqar]=[]
    var profileItem:[Menu]=[]
    
    @IBOutlet weak var bronzeAdsTxt: UILabel!
    @IBOutlet weak var silverAdsTxt: UILabel!
    @IBOutlet weak var goldenAdsTxt: UILabel!
    @IBOutlet weak var countryTxt: UILabel!
    @IBOutlet weak var mobileNumTxt: UILabel!
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var notRegistedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        notRegistedView.isHidden = true
        checkVisitor()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            let token = try KeychainWrapper.get(key: AppData.email) ?? ""
            if token != ""{
                setupData()
                getUserData()
              
            }else{
                notRegistedView.isHidden=false


            }
        }
        catch{
print(error)
            
        }
    }
    
    func setupData(){
        menuTable.register(MenuCell.self)
        profileItem=Menu.menuItem
        menuTable.delegate=self
        menuTable.dataSource=self
    }
    func checkVisitor(){
        do {
            let token = try KeychainWrapper.get(key: AppData.email) ?? ""
            if token != ""{
                setupData()
                getUserData()
              
            }else{
                notRegistedView.isHidden=false


            }
        }
        catch{
print(error)
            
        }
    }
    
    
    @IBAction func goldenPackageBtn(_ sender: Any) {
        getCarPackage(packageType: 3) { status in
            self.getAqarPackage(packageType: 3)

        }

    }
    
    
    @IBAction func silverPackageBtn(_ sender: Any) {
        getCarPackage(packageType: 2) { status in
            self.getAqarPackage(packageType: 2)

        }

    }
    
    @IBAction func registerBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: SignupVC.instantiate())
    }
    @IBAction func loginBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())
    }
    @IBAction func bronzePackageBtn(_ sender: Any) {
        getCarPackage(packageType: 1) { status in
            self.getAqarPackage(packageType: 1)

        }
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
            let vc = AddAdverstimentType.instantiate()
                    let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
                    
                   present(nav, animated: true, completion: nil)
              
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
            let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .overFullScreen
            vc.command = "logout"
           present(nav, animated: true, completion: nil)
          
 
        default:
           
print("error")
        }
   
}
}


extension ProfileVC{
    


    
    
    func getUserData(){
        ProfileManager.shared.profileDetails { Response in
            
            switch Response{
                
            case let .success(response):
                
                if response.status == true {
                    guard let responsedata = response.data else {return}
                    self.countryTxt.text=responsedata.country ?? ""
                    self.mobileNumTxt.text=responsedata.phoneNumber ?? ""
                    self.usernameTxt.text=responsedata.fullName ?? ""
                    self.aboutUsText = responsedata.aboutUs ?? ""
                    self.contactUsText = responsedata.contactUs ?? ""
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
    
    func  getCarPackage(packageType:Int,callback: @escaping callback){
        ProfileManager.shared.getUserCar(packageType: packageType) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.car = response.data?.cars ?? []
                
                  callback(true)
                }else{
                    callback(false)

                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    callback(false)

                }
            }
        }
        
    }
    
    
    func getAqarPackage(packageType:Int){
        ProfileManager.shared.getUserAqar(packageType: packageType) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.Aqar = response.data?.realStates ?? []
                    let vc = MyGoldenAds.instantiate()
                    vc.packageType=packageType
                    vc.cars = self.car
                    print(self.Aqar)
                    vc.aqars=self.Aqar
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
    }
    

}
