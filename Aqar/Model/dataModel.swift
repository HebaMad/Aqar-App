//
//  dataModel.swift
//  Aqar
//
//  Created by heba isaa on 07/03/2022.
//

import Foundation

// MARK: - Empty Model
struct Empty:Decodable{

}

struct loginModel:Decodable{
  
    let id: String?
    let accessToken:String?
    let fullName:String?
    let country:String?
    let phoneNumber:String?
    let email:String?
    let silverAdsCount:Int?
    let bronzeAdsCount:Int?
    let goldenAdsCount:Int?
    let image:String?
    let carAdvertisments:[String]?
    let realEstateAdvertisements:[String]?
    let favCarAdvertisments:[String]?
    
}

struct HomeModel:Decodable{
    
    let cars:[Car]?
    let hasMore:Bool?
   
}
struct Car:Codable{
    
    let id : Int?
    let mainImage:String?
    let modelName : String?
    let miles : Int?
    let speed : Int?
    let images : [String]?
    let title : String?
    let location : String?
    let description : String?
    let isFavourite : Bool?
    let price : Int?
    let views : Int?
    let userPhone:String?
    let userEmail:String?
    let advertismentType : Int?
    let packageType : Int?
    let latitude : Double?
    let longitude : Double?
           
}

struct AppSetting:Decodable{
    
    let id:Int?
    let parentId:Int?
    let value:String?


}
struct AqarHome:Decodable{
    let realStates:[Aqar]?
    let hasMore:Bool?

}

struct Aqar:Codable{
    
    let id : Int?
    let mainImage:String?
    let modelName : String?

    let images : [String]?
    let title : String?
    let location : String?
    let description : String?
    let isFavourite : Bool?
    let price : Int?
    let views : Int?
    let advertismentType : Int?
    let packageType : Int?
    let latitude : Double?
    let longitude : Double?
    let area:Int?
    let isArchive:Bool
    let userPhone:String?
    let userEmail:String?
    let numberOfBedrooms : Int?
    let numberOfBathrooms : Int?
    let numberOfKitchens : Int?
    let numberOfGarages : Int?


}
struct ProfileModel:Decodable{
    
    let id:String?
    let accessToken:String?
    let fullName:String?
    let country:String?
    let phoneNumber:String?
    let email:String?
    let silverAdsCount:Int?
    let bronzeAdsCount:Int?
    let goldenAdsCount:Int?
    let carAdvertisments:[String]?
    let realEstateAdvertisements:[String]?
    let favCarAdvertisments:[String]?
    let favRealEstateAdvertisments:String?
    let image:String?
    var isActive:Bool
    var contactUs:String?
    var aboutUs:String?
}
