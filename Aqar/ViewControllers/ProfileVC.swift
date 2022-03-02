//
//  ProfileVC.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit

class ProfileVC: UIViewController {
    var profileItem:[Menu]=[]
    @IBOutlet weak var menuTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData(){
        menuTable.register(MenuCell.self)
        profileItem=Menu.menuItem
        menuTable.delegate=self
        menuTable.dataSource=self
    }

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
    
    
    
    
    
    
}
