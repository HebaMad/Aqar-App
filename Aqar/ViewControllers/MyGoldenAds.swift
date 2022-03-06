//
//  MyGoldenAds.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit

class MyGoldenAds: UIViewController {

    @IBOutlet weak var adsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
    }
    func setupTableData(){
        adsTable.register(HomeCell.self)
        adsTable.delegate=self
        adsTable.dataSource=self
    }
    
    @IBAction func archievedBtn(_ sender: Any) {
    }
    
}
extension MyGoldenAds:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension MyGoldenAds:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    
}
