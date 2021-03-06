//
//  FavouriteVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit
import Moya

class FavouriteVC: UIViewController {
    var cars:[Car]=[]
    var aqars:[Aqar]=[]
    var buttonText="car"
    @IBOutlet weak var carAqarTable: UITableView!
    
    @IBOutlet weak var notRegister: UIView!
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var carView: UIView!
    
    
    @IBOutlet weak var aqarBtn: UIButton!
    @IBOutlet weak var aqarView: UIView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet var searchBar: SearchView!


    override func viewDidLoad() {
        super.viewDidLoad()

      
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TableDataSetup()
        checkVisitor()
    }

    func TableDataSetup(){
        carAqarTable.register(HomeCell.self)
        carAqarTable.delegate=self
        carAqarTable.dataSource=self
    }
    
    func checkVisitor(){
        do {
            let token = try KeychainWrapper.get(key: AppData.email) ?? ""
            if token != ""{
                notRegister.isHidden=true
                noDataView.isHidden=true

                favCar()
            }else{
                notRegister.isHidden=false
         

            }
        }
        catch{
print(error)
            
        }
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: SignupVC.instantiate())
    }
    @IBAction func loginBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: LoginChoicingVC.instantiate())
    }
    @objc func facAction(_ sender : UIButton ) {
        if buttonText == "car"{
            deleteCarFav(id: cars[sender.tag].id ?? 0)
        }else{
            
            deleteAqarFav(id: aqars[sender.tag].id ?? 0)
            
        }
}
    
    @IBAction func carButton(_ sender: Any) {
        favCar()
        buttonText="car"
        carView.backgroundColor = UIColor(named: "buton")
        aqarView.backgroundColor = UIColor(named: "view")
        carBtn.setTitleColor(.black, for: .normal)
        aqarBtn.setTitleColor(UIColor(named: "GRAY"), for: .normal)
        if cars.count != 0{
            noDataView.isHidden=true
            
        }else{
            noDataView.isHidden=false
        }
        carAqarTable.reloadData()

        
    }
    
    @IBAction func aqarButton(_ sender: Any) {
        favAqar()
        buttonText="aqar"
        aqarView.backgroundColor = UIColor(named: "buton")
        carView.backgroundColor = UIColor(named: "view")
    
        aqarBtn.setTitleColor(.black, for: .normal)
        carBtn.setTitleColor(UIColor(named: "GRAY"), for: .normal)
        if aqars.count != 0{
            noDataView.isHidden=true
            
        }else{
            noDataView.isHidden=false
        }
        carAqarTable.reloadData()
    }


}
extension FavouriteVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension FavouriteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonText == "car"{
            return cars.count
            
        }else{
            return aqars.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.editBtn.isHidden = true
        cell.removebtn.isHidden = true

        cell.FavButton.tintColor = .red
        if buttonText == "car"{
            cell.configureCarData(carData: cars[indexPath.row])
            
        }else{
            cell.configureAqarData(aqarData: aqars[indexPath.row])
            
        }
        cell.FavButton.addTarget(self, action: #selector(facAction(_:)), for: .touchUpInside)
        cell.FavButton.tag = indexPath.row
        return cell
        
       

    }
   
    
}

extension FavouriteVC{
    
    func favCar(){
        internetConnectionChecker { (status) in
            if status{
                
        ProfileManager.shared.getUserCarFav { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.cars = response.data?.cars ?? []
                    if self.cars.count != 0{
                        self.noDataView.isHidden=true
                        
                    }else{
                        self.noDataView.isHidden=false
                    }
                    self.carAqarTable.reloadData()
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "something error", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
            }
        }
        
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
    
    func favAqar(){
        internetConnectionChecker { (status) in
            if status{
                
        ProfileManager.shared.getUserAqarFav { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.aqars = response.data?.realStates ?? []
                    if self.aqars.count != 0{
                        self.noDataView.isHidden=true
                        
                    }else{
                        self.noDataView.isHidden=false
                    }
                    self.carAqarTable.reloadData()
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "something error", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
            }
        }
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
    
    
    
    func deleteCarFav(id:Int){
        internetConnectionChecker { (status) in
            if status{
                
        CarManager.shared.deleteCar(id: id) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.favCar()
                    }
                    
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "something error", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
            }
        }
        
        
        
    }else{
        UIApplication.shared.topViewController()?.showNoInternetVC()
        
    }
    }
    
    
    }
    func deleteAqarFav(id:Int){
        internetConnectionChecker { (status) in
            if status{
                
        AqarManager.shared.deleteAqar(id: id) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "Ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.favAqar()
                    }
                }
                
            case let .failure(error):
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
