//
//  HomeVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit
typealias callback = ( _ status: Bool ) -> Void

protocol filteringCarData{
    func filtering(data:carFilteringData)
}

protocol filteringAqarData{
    func filtering(data:aqarData)
}
class HomeVC: UIViewController {
    var status="New"
    var cars:[Car]=[]
    var carsF:[Car]=[]

    var aqars:[Aqar]=[]
    var aqar:aqarData?
    var car:carFilteringData?

    private var aqarpage = 0
    private var aqarhasMore = false
    
    private var carpage = 0
    private var carhasMore = false
    @IBOutlet weak var carAqarTable: UITableView!
    
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var carView: UIView!
    
    
    @IBOutlet weak var aqarBtn: UIButton!
    @IBOutlet weak var aqarView: UIView!
    @IBOutlet var searchBar: SearchView!

    var buttonText="car"
    override func viewDidLoad() {
        super.viewDidLoad()

        TableDataSetup()

//        getAllCar(miles: self.car?.miles ?? 0, speed: self.car?.speed ?? 0, priceFrom: self.car?.priceFrom ?? 0.0, priceTo: self.car?.priceTo ?? 0.0, advertisementType: self.car?.advertismentType ?? 3, dateFilterType: self.car?.date ?? 3, page:0) { status in
//
//            self.getAllAqar(numKitchens: self.aqar?.numberOfKitchens ?? 0, numBeds: self.aqar?.numberOfBedrooms ?? 0, numGarages: self.aqar?.numberOfGarages ?? 0, area: self.aqar?.area ?? 0, priceFrom: self.aqar?.priceFrom ?? 0.0, priceTo: self.aqar?.priceTo ?? 0.0, advertisementType: self.aqar?.advertismentType ?? 0, dateFilterType: self.aqar?.date ?? 0, page: 0) { status in
//
//            }
//
//        }
        
        searchBar.startHandler {
        }
  
        searchBar.endEditingHandler {
            
            if (self.searchBar.txtSearch.text)?.count != 0{
                self.cars = []
                self.aqars=[]
              
                if self.buttonText == "car"{

                self.getAllCar(miles: 0, speed: 0, priceFrom: 0.0, priceTo: 0.0, advertisementType: 3, dateFilterType:  3, page:0, search: "\(self.searchBar.txtSearch.text ?? "")") { status in
                }
                }else{
                    self.getAllAqar(numKitchens:  0, numBeds: 0, numGarages:  0, area:  0, priceFrom:  0.0, priceTo:  0.0, advertisementType:  3, dateFilterType:  3, page: 0, search: "\(self.searchBar.txtSearch.text ?? "")") { status in
                        
                    }
                    
                }
            }else{
                self.cars = []
                self.aqars=[]
                if self.buttonText == "car"{

                self.getAllCar(miles: 0, speed: 0, priceFrom: 0.0, priceTo: 0.0, advertisementType: 3, dateFilterType:  3, page:0, search: "") { status in
                }
                }else{
                    self.getAllAqar(numKitchens:  0, numBeds: 0, numGarages:  0, area:  0, priceFrom:  0.0, priceTo:  0.0, advertisementType:  3, dateFilterType:  3, page: 0, search: "") { status in
                        
                    }
                }
            
        }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
        cars=[]
        aqars=[]
        car = nil
        aqar = nil
        self.showLoading()

        getAllCar(miles: 0, speed: 0, priceFrom: 0.0, priceTo: 0.0, advertisementType: 3, dateFilterType:  3, page:0, search: "") { status in
            
            self.getAllAqar(numKitchens:  0, numBeds: 0, numGarages:  0, area:  0, priceFrom:  0.0, priceTo:  0.0, advertisementType:  3, dateFilterType:  3, page: 0, search: "") { status in
                self.hideLoading()
            }

        }
    }
    
    
    @IBAction func filterBtn(_ sender: Any) {
        if buttonText == "car"{

        let vc = CarFilterVC.instantiate()
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate=self

        present(vc, animated: true, completion: nil)
        
        
        }else{
            let vc = AqarFilterVC.instantiate()
                vc.modalPresentationStyle = .overFullScreen
            vc.delegate=self
            present(vc, animated: true, completion: nil)
            
            
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
                print(self.car)
                getAllCar(miles: self.car?.miles ?? 0, speed: self.car?.speed ?? 0, priceFrom: self.car?.priceFrom ?? 0.0, priceTo: self.car?.priceTo ?? 0.0, advertisementType: self.car?.advertismentType ?? 3, dateFilterType: self.car?.date ?? 3, page:carpage, search: ""){ status in
                        
                    }
             
            }
            }
        else{
            if aqarhasMore == true {
                aqarpage+=1
              
                self.getAllAqar(numKitchens: self.aqar?.numberOfKitchens ?? 0, numBeds: self.aqar?.numberOfBedrooms ?? 0, numGarages: self.aqar?.numberOfGarages ?? 0, area: self.aqar?.area ?? 0, priceFrom: self.aqar?.priceFrom ?? 0.0, priceTo: self.aqar?.priceTo ?? 0.0, advertisementType: self.aqar?.advertismentType ?? 0, dateFilterType: self.aqar?.date ?? 0, page:aqarpage, search: "" ){ status in
                }
            }
        }
        }
   
}
}
extension HomeVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension HomeVC:filteringAqarData{
    func filtering(data:aqarData) {
        aqar=data
        aqars=[]
        self.getAllAqar(numKitchens:data.numberOfKitchens ?? 0, numBeds: data.numberOfBedrooms ?? 0, numGarages:data.numberOfGarages ?? 0, area:data.area ?? 0, priceFrom: data.priceFrom ?? 0.0, priceTo: data.priceTo ?? 0.0, advertisementType:data.advertismentType ?? 0, dateFilterType: data.date ?? 0,page:0, search: ""){ status in
            
        }
        
    }
    
    
}
extension HomeVC:filteringCarData{
    func filtering(data: carFilteringData) {
        car=data
     cars=[]
        self.showLoading()
        getAllCar(miles: car?.miles ?? 0, speed: car?.speed ?? 0, priceFrom: car?.priceFrom ?? 0.0, priceTo: car?.priceTo ?? 0.0, advertisementType: car?.advertismentType ?? 0, dateFilterType: car?.date ?? 0, page:0, search: "") { status in
            self.hideLoading()
        }
    }
    
    
}
extension HomeVC{
    func getAllCar(miles: Int, speed: Int, priceFrom: Float, priceTo: Float, advertisementType: Int, dateFilterType: Int, page: Int,search:String, callback: @escaping callback){
        CarManager.shared.getAllCar(miles: miles, speed: speed, priceFrom: priceFrom, priceTo: priceTo, advertisementType: advertisementType, dateFilterType: dateFilterType,search:search,page: page) { Response in
            
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
    
    func getAllAqar(numKitchens:Int, numBeds: Int, numGarages: Int, area: Int, priceFrom: Float, priceTo: Float, advertisementType: Int, dateFilterType: Int,page:Int,search:String, callback: @escaping callback){
        
        AqarManager.shared.getAllAqar(numberOfKitchens: numKitchens, numberOfBeds: numBeds, numberOfGarages: numGarages, area: area, priceFrom: priceFrom, priceTo: priceTo, advertisementType: advertisementType, dateFilterType: dateFilterType, search: search, page: page) { Response in
        
      
            switch Response{

     
                  case let .success(response):
                
                if response.status == true{
                    guard let  responsedata = response.data else {return}

                do {
                    self.aqars+=responsedata.realStates ?? []
                    self.carAqarTable.reloadData()
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
                    
                    self.getAllCar(miles: self.car?.miles ?? 0, speed: self.car?.speed ?? 0, priceFrom: self.car?.priceFrom ?? 0.0, priceTo: self.car?.priceTo ?? 0.0, advertisementType: self.car?.advertismentType ?? 3, dateFilterType: self.car?.date ?? 3 ,page:0,search:"") { status in
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
                    self.getAllAqar(numKitchens: self.aqar?.numberOfKitchens ?? 0, numBeds: self.aqar?.numberOfBedrooms ?? 0, numGarages: self.aqar?.numberOfGarages ?? 0, area: self.aqar?.area ?? 0, priceFrom: self.aqar?.priceFrom ?? 0.0, priceTo: self.aqar?.priceTo ?? 0.0, advertisementType: self.aqar?.advertismentType ?? 0, dateFilterType: self.aqar?.date ?? 0, page: 0, search: ""){ status in
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
                    self.getAllCar(miles: self.car?.miles ?? 0, speed: self.car?.speed ?? 0, priceFrom: self.car?.priceFrom ?? 0.0, priceTo: self.car?.priceTo ?? 0.0, advertisementType: self.car?.advertismentType ?? 3, dateFilterType: self.car?.date ?? 3, page:0, search: "") { status in
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
                    self.getAllAqar(numKitchens: self.aqar?.numberOfKitchens ?? 0, numBeds: self.aqar?.numberOfBedrooms ?? 0, numGarages: self.aqar?.numberOfGarages ?? 0, area: self.aqar?.area ?? 0, priceFrom: self.aqar?.priceFrom ?? 0.0, priceTo: self.aqar?.priceTo ?? 0.0, advertisementType: self.aqar?.advertismentType ?? 0, dateFilterType: self.aqar?.date ?? 0, page: 0, search: ""){ status in
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
