//
//  MenuCell.swift
//  Aqar
//
//  Created by heba isaa on 02/03/2022.
//

import UIKit

class MenuCell: UITableViewCell,ReusableView,NibLoadableView  {

    @IBOutlet weak var menuTxt: UILabel!
    @IBOutlet weak var menuImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
}
