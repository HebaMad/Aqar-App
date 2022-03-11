//
//  HomeCell.swift
//  Aqar
//
//  Created by heba isaa on 01/03/2022.
//

import UIKit
import SDWebImage
class HomeCell: UITableViewCell,ReusableView,NibLoadableView {
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var backgroundImg: UIImageViewDesignable!
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var seenLabel: UILabel!
    
    @IBOutlet weak var FavButton: UIButton!
    @IBOutlet weak var optionbtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureHomeData(carData:Car){
        
//        backgroundImg.sd_setImage(with: URL(string: carData.images?[0] ?? "" ))
        titleTxt.text=carData.title
        descriptionText.text=carData.description
        seenLabel.text="\(carData.views ?? 0)"
        
        if carData.isFavourite == true {
            FavButton.tintColor = .red
        }else{
            FavButton.tintColor = UIColor(named: "view")
        }
        
        
    }
    
}
