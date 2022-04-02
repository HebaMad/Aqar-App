//
//  NoInternetVC.swift
//  Rakwa
//
//  Created by moumen isawe on 19/12/2021.
//

import UIKit

class NoInternetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 


    }
    
    @IBAction func checkInterntConnection(){
        internetConnectionChecker { (status) in
            if status{
     self.dismiss(animated: true, completion: nil)

            }

    }
}
}
