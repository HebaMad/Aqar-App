//
//  AqarNetworkable.swift
//  Aqar
//
//  Created by heba isaa on 08/03/2022.
//

import Foundation
import Moya

protocol AqarNetworkable:Networkable  {
    
    func getAllAqar(page:Int,completion: @escaping (Result<BaseResponse<AqarHome>, Error>) -> ())
    func deleteAqar(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func aqarDetails(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
func AddAqar(Area:String,NumberOfBedrooms:Int,NumberOfBathrooms:Int,NumberOfKitchens:Int,NumberOfGarages:Int,imags:[Data],Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    
    func UpdateAqar(id:Int,Area:String,NumberOfBedrooms:Int,NumberOfBathrooms:Int,NumberOfKitchens:Int,NumberOfGarages:Int,imags:[Data],Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    
    func AqarFiltering(numberOfKitchens:Int,numberOfBeds:Int,numberOfGarages:Int,area:Int,priceFrom:Int,priceTo:Int,advertisementType:Int,dateFilterType:Int,page:Int,completion: @escaping (Result<BaseResponse<AqarHome>, Error>)-> ())
    
}
class AqarManager:AqarNetworkable{


   var provider: MoyaProvider<AqarApiTarget> = MoyaProvider<AqarApiTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: AqarManager = {
       let generalActions = AqarManager()
       return generalActions
   }()
   typealias targetType = AqarApiTarget

 
    func AqarFiltering(numberOfKitchens: Int, numberOfBeds: Int, numberOfGarages: Int, area: Int, priceFrom: Int, priceTo: Int, advertisementType: Int, dateFilterType: Int, page: Int, completion: @escaping (Result<BaseResponse<AqarHome>, Error>) -> ()) {
        request(target: .AqarFiltering(numberOfKitchens: numberOfKitchens, numberOfBeds: numberOfBeds, numberOfGarages: numberOfGarages, area: area, priceFrom: priceFrom, priceTo: priceTo, advertisementType: advertisementType, dateFilterType: dateFilterType, page: page), completion: completion)
    }
    



    func getAllAqar(page:Int,completion: @escaping (Result<BaseResponse<AqarHome>, Error>) -> ()) {
        request(target: .getAllAqar(page: page), completion: completion)
    }
    
    func deleteAqar(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteAqar(id: id), completion: completion)
    }
    
    func aqarDetails(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .AqarDetails(id: id), completion: completion)
    }
    
    func AddAqar(Area: String, NumberOfBedrooms: Int, NumberOfBathrooms: Int, NumberOfKitchens: Int, NumberOfGarages: Int, imags: [Data], Title: String, Location: String, Description: String, Price: Int, AdvertismentType: Int, PackageType: Int, Longitude: String, Latitude: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .AddAqar(Area: Area, NumberOfBedrooms: NumberOfBedrooms, NumberOfBathrooms: NumberOfBathrooms, NumberOfKitchens: NumberOfKitchens, NumberOfGarages: NumberOfGarages, imags: imags, Title: Title, Location: Location, Description: Description, Price: Price, AdvertismentType: AdvertismentType, PackageType: PackageType, Longitude: Longitude, Latitude: Latitude), completion: completion)
    }
    func UpdateAqar(id:Int,Area: String, NumberOfBedrooms: Int, NumberOfBathrooms: Int, NumberOfKitchens: Int, NumberOfGarages: Int, imags: [Data], Title: String, Location: String, Description: String, Price: Int, AdvertismentType: Int, PackageType: Int, Longitude: String, Latitude: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateAqar(id:id,Area: Area, NumberOfBedrooms: NumberOfBedrooms, NumberOfBathrooms: NumberOfBathrooms, NumberOfKitchens: NumberOfKitchens, NumberOfGarages: NumberOfGarages, imags: imags, Title: Title, Location: Location, Description: Description, Price: Price, AdvertismentType: AdvertismentType, PackageType: PackageType, Longitude: Longitude, Latitude: Latitude), completion: completion)
    }
    

  

    

}
