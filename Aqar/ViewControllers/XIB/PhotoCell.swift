//
//  PhotoCell.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit
import SDWebImage
class PhotoCell: UICollectionViewCell,ReusableView,NibLoadableView   {
    
    @IBOutlet weak var realstatePhoto: UIImageView!
    
    func configureImage(realstateImage:String){
        realstatePhoto.sd_setImage(with: URL(string: realstateImage))
    }
}
