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
   
}
struct Car:Codable{
    
    let id : Int?
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
    let advertismentType : Int?
    let packageType : Int?
    let latitude : Int?
    let longitude : Int?
           
}
