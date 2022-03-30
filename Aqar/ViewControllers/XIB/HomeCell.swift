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
    @IBOutlet weak var removebtn: UIButton!
    
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var adverstimentTypeTxt: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func configureCarData(carData:Car){
        
        backgroundImg.sd_setImage(with: URL(string: carData.mainImage ?? ""))
        titleTxt.text=carData.title
        descriptionText.text=carData.description
        seenLabel.text="\(carData.views ?? 0)"
        
        if carData.isFavourite == true {
            FavButton.tintColor = .red
        }else{
            FavButton.tintColor = UIColor(named: "view")
        }
        
        if carData.advertismentType == 1{
            adverstimentTypeTxt.setTitle("Rent", for: .normal)
        }else{
            adverstimentTypeTxt.setTitle("Purchase", for: .normal)

        }
        
        
    }
    
    func configureAqarData(aqarData:Aqar){
        
        backgroundImg.sd_setImage(with: URL(string: aqarData.mainImage ?? ""))
        titleTxt.text=aqarData.title
        descriptionText.text=aqarData.description
        seenLabel.text="\(aqarData.views ?? 0)"
        
        if aqarData.isFavourite == true {
            FavButton.tintColor = .red
        }else{
            FavButton.tintColor = UIColor(named: "view")
        }
        
        if aqarData.advertismentType == 1{
            adverstimentTypeTxt.setTitle("Rent", for: .normal)
            
        }else{
            adverstimentTypeTxt.setTitle("Purchase", for: .normal)

        }
        
        
    }
    
}
