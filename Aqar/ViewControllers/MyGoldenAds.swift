//
//  MyGoldenAds.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit

class MyGoldenAds: UIViewController {
    var cars:[Car]=[]
    var aqars:[Aqar]=[]
    var buttonText="car"
    var packageType=1
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var carView: UIView!
    
    
    @IBOutlet weak var aqarBtn: UIButton!
    @IBOutlet weak var aqarView: UIView!
    @IBOutlet weak var adsTable: UITableView!
    
    
    @IBOutlet weak var noDataView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if cars.count != 0{
            noDataView.isHidden=true
            
        }else{
            noDataView.isHidden=false
        }
        
        setupTableData()
    }
    func setupTableData(){
        adsTable.register(HomeCell.self)
        adsTable.delegate=self
        adsTable.dataSource=self
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @objc func deleteAction(_ sender : UIButton ) {
        if buttonText == "car"{
            deleteCar(id: cars[sender.tag].id ?? 0)
        }else{
            
            deleteAqar(id: aqars[sender.tag].id ?? 0)
            
        }
}
    
    
    @IBAction func archievedBtn(_ sender: Any) {
    }
    @IBAction func carButton(_ sender: Any) {
        
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
        self.adsTable.reloadData()
        
        
    }
    
    @IBAction func aqarButton(_ sender: Any) {
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
        self.adsTable.reloadData()
        
        
    }
    
    
}
extension MyGoldenAds:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension MyGoldenAds:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonText == "car"{
            return cars.count
            
        }else{
            return aqars.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.FavButton.isHidden = true
        if buttonText == "car"{
            cell.configureCarData(carData: cars[indexPath.row])
            
        }else{
            cell.configureAqarData(aqarData: aqars[indexPath.row])
            
        }
        cell.removebtn.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
        cell.removebtn.tag = indexPath.row
        return cell
    }
    
    
}

extension MyGoldenAds{
    func  getCarPackage(packageType:Int){
        ProfileManager.shared.getUserCar(packageType: packageType) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.cars = response.data?.cars ?? []
                    self.adsTable.reloadData()

                    
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
        
    }
    
    
    func getAqarPackage(packageType:Int){
        ProfileManager.shared.getUserAqar(packageType: packageType) { Response in
            switch Response{

         
            case let .success(response):
                if response.status == true{
                    self.aqars = response.data?.realStates ?? []
                    self.adsTable.reloadData()
                }
                
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
    }
    func deleteCar(id:Int){
        CarManager.shared.deleteCar(id: id) { Response in
            switch Response{
                
                
            case let .success(response):
                
                if response.status == true {
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "OK", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.getCarPackage(packageType: self.packageType)
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
    func deleteAqar(id:Int){
        AqarManager.shared.deleteAqar(id: id) { Response in
            switch Response{
                
                
            case let .success(response):
                
                if response.status == true {
                    self.showAlert(title:  "Success", message: response.message, confirmBtnTitle: "OK", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.getAqarPackage(packageType: self.packageType)
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
