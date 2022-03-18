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
        return cell
    }
    
    
}
