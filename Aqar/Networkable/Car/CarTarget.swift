//
//  CarTarget.swift
//  Aqar
//
//  Created by heba isaa on 08/03/2022.
//

import Foundation


import Moya

enum CarApiTarget:TargetType{
    case getAllCar
    case AddCar(ModelName:String,Miles:Int,Speed:Int,imags:Data,Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String)
    
    case updateCar(id:Int,ModelName:String,Miles:Int,Speed:Int,imags:Data,Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String)
    
    case deleteCar(id:Int)
    case carDetails(id:Int)
    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)/RealEstateAdvertisment/")!
    }
    
    
    var path: String {
        switch self {
        case .getAllCar:return "GetAll"
        case .AddCar: return "Create"
        case .updateCar:return "Update"
        case .deleteCar : return "Delete"
        case .carDetails:return "GetOne"
    
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .deleteCar:
            return .delete
        case .getAllCar,.carDetails:
            return .get
        case .AddCar,.updateCar:
            // change this later
            return Method.post
          

        
        }
    }
    
    var task: Task{
        switch self{
  
        case .getAllCar:
            return .requestPlain
        case .deleteCar,.carDetails:
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)

   
        case .AddCar(let ModelName,let Miles,let Speed,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            
         let pngData = MultipartFormData(provider: .data(imags), name: "Images", fileName: "images", mimeType: "image/png")
      
            let modelName = MultipartFormData(provider: .data(ModelName.data(using: .utf8)!), name: "ModelName")
            let miles = MultipartFormData(provider: .data("\(Miles)".data(using: .utf8)!), name: "Miles")
            let speed = MultipartFormData(provider: .data("\(Speed)".data(using: .utf8)!), name: "Speed")
            let title = MultipartFormData(provider: .data(Title.data(using: .utf8)!), name: "Title")

            let location = MultipartFormData(provider: .data(Location.data(using: .utf8)!), name: "Location")
            let description = MultipartFormData(provider: .data(Description.data(using: .utf8)!), name: "Description")
            let price = MultipartFormData(provider: .data("\(Price)".data(using: .utf8)!), name: "Price")
            let advertismentType = MultipartFormData(provider: .data("\(AdvertismentType)".data(using: .utf8)!), name: "AdvertismentType")
            let packageType = MultipartFormData(provider: .data("\(PackageType)".data(using: .utf8)!), name: "PackageType")
            let longitude = MultipartFormData(provider: .data(Longitude.data(using: .utf8)!), name: "Longitude")
            let latitude = MultipartFormData(provider: .data(Latitude.data(using: .utf8)!), name: "Latitude")

            
            let multipartData = [pngData, modelName,miles,speed,title,location,description,price,advertismentType,packageType,longitude,latitude]

                      return .uploadMultipart(multipartData)
            
        case .updateCar(let id,let ModelName,let Miles,let Speed,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            
         let pngData = MultipartFormData(provider: .data(imags), name: "Images", fileName: "images", mimeType: "image/png")
            let modelName = MultipartFormData(provider: .data(ModelName.data(using: .utf8)!), name: "ModelName")
            let miles = MultipartFormData(provider: .data("\(Miles)".data(using: .utf8)!), name: "Miles")
            let speed = MultipartFormData(provider: .data("\(Speed)".data(using: .utf8)!), name: "Speed")
            let title = MultipartFormData(provider: .data(Title.data(using: .utf8)!), name: "Title")

            let location = MultipartFormData(provider: .data(Location.data(using: .utf8)!), name: "Location")
            let description = MultipartFormData(provider: .data(Description.data(using: .utf8)!), name: "Description")
            let price = MultipartFormData(provider: .data("\(Price)".data(using: .utf8)!), name: "Price")
            let advertismentType = MultipartFormData(provider: .data("\(AdvertismentType)".data(using: .utf8)!), name: "AdvertismentType")
            let packageType = MultipartFormData(provider: .data("\(PackageType)".data(using: .utf8)!), name: "PackageType")
            let longitude = MultipartFormData(provider: .data(Longitude.data(using: .utf8)!), name: "Longitude")
            let latitude = MultipartFormData(provider: .data(Latitude.data(using: .utf8)!), name: "Latitude")
            let id = MultipartFormData(provider: .data("\(id)".data(using: .utf8)!), name: "Id")
            
            let multipartData = [pngData,modelName,miles,speed,title,location,description,price,advertismentType,packageType,longitude,latitude,id]

                      return .uploadMultipart(multipartData)
            
        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .AddCar,.updateCar,.deleteCar:
            
            do {
                let token = try KeychainWrapper.get(key: AppData.email) ?? ""
                return ["token":token ,"Accept":"application/json"]
            }
            catch{
                return ["Accept":"application/json"]
            }
      
            
        default:return ["Accept":"application/json"]
        }
        
        
    }
    var param: [String : Any]{
        
        
        switch self {
        case .carDetails(let id):
            return ["Id":id]
        case .deleteCar(let id):
            return ["Id":id]
            
        case .updateCar(let id,let ModelName,let Miles,let Speed,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            return ["Id":id,"ModelName":ModelName,"Miles":Miles,"Speed":Speed,"imags":imags,"Title":Title,"Location":Location,"Description":Description,"Price":Price,"AdvertismentType":AdvertismentType,"PackageType":PackageType,"Longitude":Longitude,"Latitude":Latitude]
            
        case .AddCar(let ModelName,let Miles,let Speed,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            return["ModelName":ModelName,"Miles":Miles,"Speed":Speed,"imags":imags,"Title":Title,"Location":Location,"Description":Description,"Price":Price,"AdvertismentType":AdvertismentType,"PackageType":PackageType,"Longitude":Longitude,"Latitude":Latitude]

        default : return [:]
        }
       
        
    }
}

