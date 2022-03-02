//
//  HomeVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var carAqarTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        TableDataSetup()
        
    }
    func TableDataSetup(){
        carAqarTable.register(HomeCell.self)
        carAqarTable.delegate=self
        carAqarTable.dataSource=self
    }


}
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
        
    }
    
    
    
    
    
    
    
}
