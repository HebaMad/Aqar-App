//
//  SettingMenu.swift
//  Aqar
//
//  Created by heba isaa on 02/03/2022.
//

import Foundation
import UIKit

enum menu{
     static let menuItem = [NewAdvertisement,EditProfile,ContactUs,AboutUs,LogOut]
   case NewAdvertisement
    case EditProfile
    case ContactUs
    case AboutUs
    case LogOut
    
    var menuImg:UIImage?{
        
        switch(self){
        case .NewAdvertisement:
            return UIImage(named: "adv")
            
        case .EditProfile:
            return UIImage(named: "Setting")
            
        case .ContactUs:
            return UIImage(named: "Call")
            
        case .AboutUs:
            return UIImage(named: "About")
            
        case .LogOut:
            return UIImage(named: "Logout")
            
            
            
        }
    
    }
    
    var menuText:String{
        
        switch(self){
        case .NewAdvertisement:
            return "New Advertisement"
            
        case .EditProfile:
            return "Edit Profile"
            
        case .ContactUs:
            return "Contact Us"
            
        case .AboutUs:
            return "About Us"
            
        case .LogOut:
            return "LogOut"
            
            
            
            
        }
        
        
    }
    
    
}
