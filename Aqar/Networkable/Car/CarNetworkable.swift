//
//  CarNetworkable.swift
//  Aqar
//
//  Created by heba isaa on 08/03/2022.
//

import Foundation

import Foundation
import Moya

protocol CarNetworkable:Networkable  {
    
    func getAllCar(page:Int,completion: @escaping (Result<BaseResponse<HomeModel>, Error>) -> ())
    func deleteCar(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func CarDetails(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
func AddCar(ModelName:String,Miles:Int,Speed:Int,imags:[Data],Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    
    func updateCar(id:Int,ModelName:String,Miles:Int,Speed:Int,imags:[Data],Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func carFiltering(miles:Int,speed:Int,priceFrom:Int,priceTo:Int,advertisementType:Int,dateFilterType:Int,page:Int,completion: @escaping (Result<BaseResponse<HomeModel>, Error>) -> ())

}
class CarManager:CarNetworkable{

    
   var provider: MoyaProvider<CarApiTarget> = MoyaProvider<CarApiTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: CarManager = {
       let generalActions = CarManager()
       return generalActions
   }()
   typealias targetType = CarApiTarget

 
    func getAllCar(page:Int,completion: @escaping (Result<BaseResponse<HomeModel>, Error>) -> ()) {
        request(target: .getAllCar(page: page), completion: completion)

    }
    func carFiltering(miles: Int, speed: Int, priceFrom: Int, priceTo: Int, advertisementType: Int, dateFilterType: Int, page: Int, completion: @escaping (Result<BaseResponse<HomeModel>, Error>) -> ()) {
        request(target: .carFiltering(miles: miles, speed: speed, priceFrom: priceFrom, priceTo: priceTo, advertisementType: advertisementType, dateFilterType: dateFilterType, page: page), completion: completion)
    }
    func deleteCar(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteCar(id: id), completion: completion)
    }
    
    func CarDetails(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .carDetails(id: id), completion: completion)
        
    }
    func AddCar(ModelName: String, Miles: Int, Speed: Int, imags: [Data], Title: String, Location: String, Description: String, Price: Int, AdvertismentType: Int, PackageType: Int, Longitude: String, Latitude: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .AddCar(ModelName: ModelName, Miles: Miles, Speed: Speed, imags: imags, Title: Title, Location: Location, Description: Description, Price: Price, AdvertismentType: AdvertismentType, PackageType: PackageType, Longitude: Longitude, Latitude: Latitude), completion: completion)
    }
    
    func updateCar(id: Int, ModelName: String, Miles: Int, Speed: Int, imags: [Data], Title: String, Location: String, Description: String, Price: Int, AdvertismentType: Int, PackageType: Int, Longitude: String, Latitude: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateCar(id: id,ModelName: ModelName, Miles: Miles, Speed: Speed, imags: imags, Title: Title, Location: Location, Description: Description, Price: Price, AdvertismentType: AdvertismentType, PackageType: PackageType, Longitude: Longitude, Latitude: Latitude), completion: completion)
    }
}
