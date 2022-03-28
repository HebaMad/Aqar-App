//
//  HomeVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit
typealias callback = ( _ status: Bool ) -> Void

class HomeVC: UIViewController {
    var cars:[Car]=[]
    var aqars:[Aqar]=[]
    private var aqarpage = 0
    private var aqarhasMore = false
    
    private var carpage = 0
    private var carhasMore = false
    @IBOutlet weak var carAqarTable: UITableView!
    
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var carView: UIView!
    
    
    @IBOutlet weak var aqarBtn: UIButton!
    @IBOutlet weak var aqarView: UIView!
    
    var buttonText="car"
    override func viewDidLoad() {
        super.viewDidLoad()

        TableDataSetup()
        getAllCar(pageNum: carpage) { status in
            self.getAllAqar(pageNum: self.aqarpage) { status in
                
            }

        }
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
    @objc func favAction(_ sender : UIButton ) {
        
        do {
            let token = try KeychainWrapper.get(key: AppData.email) ?? ""
            if token != ""{
                if buttonText == "car"{
                    
                    if cars[sender.tag].isFavourite == true{
                        self.showLoading()

                        deleteCarFav(id: cars[sender.tag].id ?? 0)

                        
                    }else{
                        self.showLoading()

                       AddCarFav(id: cars[sender.tag].id ?? 0)

                    }
                    
                    
                }else{
                    
                    if aqars[sender.tag].isFavourite == true{
                        self.showLoading()

                        deleteAqarFav(id:  aqars[sender.tag].id ?? 0)

                    }else{
                        self.showLoading()

                        AddAqarFav(id:  aqars[sender.tag].id ?? 0)
                        
                    }
                    
                    
                }
              
            }else{
                self.showAlert(title:  "Notice", message: "you should login to complete your event", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }

            }
        }
        catch{
print(error)
            
        }
 
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
        cell.editBtn.isHidden = true
        cell.removebtn.isHidden = true

        if buttonText == "car"{
            cell.configureCarData(carData: cars[indexPath.row])

        }else{
            cell.configureAqarData(aqarData: aqars[indexPath.row])

        }
        cell.FavButton.addTarget(self, action: #selector(favAction(_:)), for: .touchUpInside)
        cell.FavButton.tag = indexPath.row
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if Int(distanceFromBottom) == Int(height) {
        
        if buttonText == "car"{
            if carhasMore == true {
                carpage+=1
                getAllCar(pageNum: carpage) { status in
                    
                }
            }
          
        }else{
            if aqarhasMore == true {
                aqarpage+=1
                getAllCar(pageNum: aqarpage) { status in
                    
                }
            }
        }
    }
    }
}
extension HomeVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension HomeVC{
    func getAllCar(pageNum:Int, callback: @escaping callback){
        CarManager.shared.getAllCar(page:pageNum) { Response in
            
            switch Response{

     
                  case let .success(response):
                
                if response.status == true{
                    guard let  responsedata = response.data else {return}

                do {
                    self.cars+=responsedata.cars ?? []
                    self.carAqarTable.reloadData()
                    self.carhasMore=responsedata.hasMore ?? false
                 callback(true)
                } catch let error {
                }
                    
                }else{
                    self.showAlert(title: "Failed", message: response.message)
                    callback(false)
                }
                
                  case let .failure(error):
      
                      self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
      
                      }
      
  }
        }
    }
    
    func getAllAqar(pageNum:Int, callback: @escaping callback){
        AqarManager.shared.getAllAqar(page:pageNum) { Response in
            switch Response{

     
                  case let .success(response):
                
                if response.status == true{
                    guard let  responsedata = response.data else {return}

                do {
                    self.aqars+=responsedata.realStates ?? []
                    self.aqarhasMore=responsedata.hasMore ?? false
                    callback(true)

                } catch let error {
                }
                    
                }else{
                    self.showAlert(title: "Failed", message: response.message)
                    callback(false)

                }
                
                  case let .failure(error):
      
                      self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
      
                      }
      
  }
        }
    }
    
    func deleteCarFav(id:Int){
        ProfileManager.shared.removeFavCar(id: id) { Response in
            switch Response{

            case let .success(response):
                if response.status == true{
                    self.cars=[]
                    self.getAllCar(pageNum: 0) { status in
                        self.hideLoading()
                        self.showAlert(title:  "Sucess", message: response.message, confirmBtnTitle: "ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                        }
               
            }
                }
                self.hideLoading()

            case let .failure(error):
                self.hideLoading()

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
        
        
        
    }
    func deleteAqarFav(id:Int){

        ProfileManager.shared.removeFavAqar(id: id) { Response in
            switch Response{

         
            case let .success(response):

                if response.status == true{
                    self.aqars=[]
                    self.getAllAqar(pageNum: 0) { status in
                        self.hideLoading()
                        self.showAlert(title:  "Sucess", message: response.message, confirmBtnTitle: "ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                        }
               
            }
                }

            case let .failure(error):
                self.hideLoading()

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
        
        
        
    }
    
    func AddCarFav(id:Int){
        ProfileManager.shared.addFavCar(id: id) { Response in
            switch Response{

         
            case let .success(response):

                if response.status == true{

                    self.cars=[]
                    self.getAllCar(pageNum: 0) { status in
                        self.hideLoading()
                        self.showAlert(title:  "Sucess", message: response.message, confirmBtnTitle: "ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                        }
               
            }
                }
                
            case let .failure(error):
                self.hideLoading()

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                }
            }
        }
        
    }
    func AddAqarFav(id:Int){
        ProfileManager.shared.addFavAqar(id: id) { Response in
            switch Response{

            case let .success(response):

                if response.status == true{
                        self.aqars=[]
                        self.getAllAqar(pageNum: 0) { status in
                            self.hideLoading()
                            self.showAlert(title:  "Sucess", message: response.message, confirmBtnTitle: "ok", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in

                            }
                   
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
