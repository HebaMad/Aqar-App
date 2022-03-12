//
//  HomeVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class HomeVC: UIViewController {
    var cars:[Car]=[]
    var aqars:[Aqar]=[]
    
    @IBOutlet weak var carAqarTable: UITableView!
    
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var carView: UIView!
    
    
    @IBOutlet weak var aqarBtn: UIButton!
    @IBOutlet weak var aqarView: UIView!
    
    var buttonText="car"
    override func viewDidLoad() {
        super.viewDidLoad()

        TableDataSetup()
        getAllCar()
        getAllAqar()
    }
    
    func TableDataSetup(){
        carAqarTable.register(HomeCell.self)
        carAqarTable.delegate=self
        carAqarTable.dataSource=self
    }
    
    
    @IBAction func carButton(_ sender: Any) {
        
        buttonText="car"
        carView.backgroundColor = UIColor(named: "buton")
        aqarView.backgroundColor = UIColor(named: "view")
        carBtn.setTitleColor(.black, for: .normal)
        aqarBtn.setTitleColor(UIColor(named: "GRAY"), for: .normal)
        self.carAqarTable.reloadData()

        
    }
    
    @IBAction func aqarButton(_ sender: Any) {
        buttonText="aqar"
        aqarView.backgroundColor = UIColor(named: "buton")
        carView.backgroundColor = UIColor(named: "view")
    
        aqarBtn.setTitleColor(.black, for: .normal)
        carBtn.setTitleColor(UIColor(named: "GRAY"), for: .normal)
        self.carAqarTable.reloadData()

        
    }
    

}
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonText == "car"{
            return cars.count

        }else{
            return aqars.count

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.optionbtn.isHidden = true
        if buttonText == "car"{
            cell.configureCarData(carData: cars[indexPath.row])

        }else{
            cell.configureAqarData(aqarData: aqars[indexPath.row])

        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc=DetailsVC.instantiate()
        if buttonText == "car"{
            vc.stateType = "car"
            vc.carDetails=cars[indexPath.row]

        }else{
            vc.stateType = "aqar"

            vc.aqarDetails = aqars[indexPath.row]

        }
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    }
  
}
extension HomeVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension HomeVC{
    func getAllCar(){
        CarManager.shared.getAllCar { Response in
            
            switch Response{

     
                  case let .success(response):
                
                if response.status == true{
                    guard let  responsedata = response.data else {return}

                do {
                    self.cars=responsedata.cars ?? []
                    self.carAqarTable.reloadData()

                } catch let error {
                }
                    
                }else{
                    self.showAlert(title: "Failed", message: response.message)

                }
                
                  case let .failure(error):
      
                      self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
      
                      }
      
  }
        }
    }
    
    func getAllAqar(){
        AqarManager.shared.getAllAqar { Response in
            switch Response{

     
                  case let .success(response):
                
                if response.status == true{
                    guard let  responsedata = response.data else {return}

                do {
                    self.aqars=responsedata.realStates ?? []

                } catch let error {
                }
                    
                }else{
                    self.showAlert(title: "Failed", message: response.message)

                }
                
                  case let .failure(error):
      
                      self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
      
                      }
      
  }
        }
    }
    
    
    
    
}
