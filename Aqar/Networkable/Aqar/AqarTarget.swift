//
//  AqarTarget.swift
//  Aqar
//
//  Created by heba isaa on 08/03/2022.
//

import Foundation


import Moya

enum AqarApiTarget:TargetType{
    case getAllAqar(page:Int)
    case AddAqar(Area:String,NumberOfBedrooms:Int,NumberOfBathrooms:Int,NumberOfKitchens:Int,NumberOfGarages:Int,imags:[Data],Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String)
    
    case updateAqar(id:Int,Area:String,NumberOfBedrooms:Int,NumberOfBathrooms:Int,NumberOfKitchens:Int,NumberOfGarages:Int,imags:[Data],Title:String,Location:String,Description:String,Price:Int,AdvertismentType:Int,PackageType:Int,Longitude:String,Latitude:String)
    
    case deleteAqar(id:Int)
    case AqarDetails(id:Int)
    case AqarFiltering(numberOfKitchens:Int,numberOfBeds:Int,numberOfGarages:Int,area:Int,priceFrom:Int,priceTo:Int,advertisementType:Int,dateFilterType:Int,page:Int)
    
    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)/RealEstateAdvertisment/")!
    }
    
    
    var path: String {
        switch self {
        case .getAllAqar:return "GetAll"
        case .AddAqar: return "Create"
        case .updateAqar:return "Update"
        case .deleteAqar : return "Delete"
        case .AqarDetails:return "GetOne"
        case .AqarFiltering:return "GetAll"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .updateAqar:
            return Method.put
        case .deleteAqar:
            return .delete
        case .getAllAqar,.AqarDetails,.AqarFiltering:
            return .get
        case .AddAqar:
            // change this later
            return Method.post
          

        
        }
    }
    
    var task: Task{
        switch self{
  
        case .deleteAqar,.AqarDetails,.getAllAqar,.AqarFiltering:
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)

        case .AddAqar:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)

        case .AddAqar(let Area,let NumberOfBedrooms,let NumberOfBathrooms,let NumberOfKitchens,let NumberOfGarages,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            var multipartData:[MultipartFormData]=[]

       
           let area = MultipartFormData(provider: .data(Area.data(using: .utf8)!), name: "Area")
            let numBedrooms = MultipartFormData(provider: .data("\(NumberOfBedrooms)".data(using: .utf8)!), name: "NumberOfBedrooms")
            let numBathrooms = MultipartFormData(provider: .data("\(NumberOfBathrooms)".data(using: .utf8)!), name: "NumberOfBathrooms")
            let numKitchens = MultipartFormData(provider: .data("\(NumberOfKitchens)".data(using: .utf8)!), name: "NumberOfKitchens")
            let numGarages = MultipartFormData(provider: .data("\(NumberOfGarages)".data(using: .utf8)!), name: "NumberOfGarages")
            let title = MultipartFormData(provider: .data(Title.data(using: .utf8)!), name: "Title")

            let location = MultipartFormData(provider: .data(Location.data(using: .utf8)!), name: "Location")
            let description = MultipartFormData(provider: .data(Description.data(using: .utf8)!), name: "Description")
            let price = MultipartFormData(provider: .data("\(Price)".data(using: .utf8)!), name: "Price")
            let advertismentType = MultipartFormData(provider: .data("\(AdvertismentType)".data(using: .utf8)!), name: "AdvertismentType")
            let packageType = MultipartFormData(provider: .data("\(PackageType)".data(using: .utf8)!), name: "PackageType")
            let longitude = MultipartFormData(provider: .data(Longitude.data(using: .utf8)!), name: "Longitude")
            let latitude = MultipartFormData(provider: .data(Latitude.data(using: .utf8)!), name: "Latitude")

            
            multipartData = [ area,numBedrooms,numBathrooms,numKitchens,numGarages,title,location,description,price,advertismentType,packageType,longitude,latitude]
            
            for index in 0 ... imags.count - 1 {
                multipartData.append(MultipartFormData(provider: .data(imags[index]), name: "Images", fileName: "images.jpeg", mimeType: "image/jpeg"))

            }

                      return .uploadMultipart(multipartData)
            
        case .updateAqar(let id,let Area,let NumberOfBedrooms,let NumberOfBathrooms,let NumberOfKitchens,let NumberOfGarages,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            var multipartData:[MultipartFormData]=[]

           let area = MultipartFormData(provider: .data(Area.data(using: .utf8)!), name: "Area")
            let numBedrooms = MultipartFormData(provider: .data("\(NumberOfBedrooms)".data(using: .utf8)!), name: "NumberOfBedrooms")
            let numBathrooms = MultipartFormData(provider: .data("\(NumberOfBathrooms)".data(using: .utf8)!), name: "NumberOfBathrooms")
            let numKitchens = MultipartFormData(provider: .data("\(NumberOfKitchens)".data(using: .utf8)!), name: "NumberOfKitchens")
            let numGarages = MultipartFormData(provider: .data("\(NumberOfGarages)".data(using: .utf8)!), name: "NumberOfGarages")
            let title = MultipartFormData(provider: .data(Title.data(using: .utf8)!), name: "Title")

            let location = MultipartFormData(provider: .data(Location.data(using: .utf8)!), name: "Location")
            let description = MultipartFormData(provider: .data(Description.data(using: .utf8)!), name: "Description")
            let price = MultipartFormData(provider: .data("\(Price)".data(using: .utf8)!), name: "Price")
            let advertismentType = MultipartFormData(provider: .data("\(AdvertismentType)".data(using: .utf8)!), name: "AdvertismentType")
            let packageType = MultipartFormData(provider: .data("\(PackageType)".data(using: .utf8)!), name: "PackageType")
            let longitude = MultipartFormData(provider: .data(Longitude.data(using: .utf8)!), name: "Longitude")
            let latitude = MultipartFormData(provider: .data(Latitude.data(using: .utf8)!), name: "Latitude")
            let id = MultipartFormData(provider: .data("\(id)".data(using: .utf8)!), name: "Id")
            
            
            multipartData = [id,area,numBedrooms,numBathrooms,numKitchens,numGarages,title,location,description,price,advertismentType,packageType,longitude,latitude]
            
            for index in 0 ... imags.count - 1 {
                multipartData.append(MultipartFormData(provider: .data(imags[index]), name: "Images", fileName: "images.jpeg", mimeType: "image/jpeg"))

            }

                      return .uploadMultipart(multipartData)
            
        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .AddAqar,.updateAqar,.deleteAqar,.getAllAqar,.AqarFiltering:
            
            do {
                let token = try KeychainWrapper.get(key: AppData.email) ?? ""
                return ["Authorization":token ,"Accept":"application/json"]
            }
            catch{
                return ["Accept":"application/json"]
            }
      
            
        default:return ["Accept":"application/json"]
        }
        
        
    }
    var param: [String : Any]{
        
        
        switch self {
            
        case .AqarFiltering(let numberOfKitchens,let numberOfBeds,let numberOfGarages,let area,let priceFrom,let priceTo,let advertisementType,let dateFilterType,let page):
            return["numberOfKitchens":numberOfKitchens,"numberOfBeds":numberOfBeds,"numberOfGarages":numberOfGarages,"area":area,"priceFrom":priceFrom,"priceTo":priceTo,"advertisementType":advertisementType,"dateFilterType":dateFilterType,"page":page]
        case .getAllAqar(let page):
            return["page":page]

        case .AqarDetails(let id):
            return ["carId":id]
        case .deleteAqar(let id):
            return ["Id":id]
            
        case .updateAqar(let id,let Area,let NumberOfBedrooms,let NumberOfBathrooms,let NumberOfKitchens,let NumberOfGarages,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            return ["Id":id,"Area":Area,"NumberOfBedrooms":NumberOfBedrooms,"NumberOfBathrooms":NumberOfBathrooms,"NumberOfKitchens":NumberOfKitchens,"NumberOfGarages":NumberOfGarages,"imags":imags,"Title":Title,"Location":Location,"Description":Description,"Price":Price,"AdvertismentType":AdvertismentType,"PackageType":PackageType,"Longitude":Longitude,"Latitude":Latitude]
            
        case .AddAqar(let Area,let NumberOfBedrooms,let NumberOfBathrooms,let NumberOfKitchens,let NumberOfGarages,let imags,let Title,let Location,let Description,let Price,let AdvertismentType,let PackageType,let Longitude,let Latitude):
            return["Area":Area,"NumberOfBedrooms":NumberOfBedrooms,"NumberOfBathrooms":NumberOfBathrooms,"NumberOfKitchens":NumberOfKitchens,"NumberOfGarages":NumberOfGarages,"imags":imags,"Title":Title,"Location":Location,"Description":Description,"Price":Price,"AdvertismentType":AdvertismentType,"PackageType":PackageType,"Longitude":Longitude,"Latitude":Latitude]

        default : return [:]
        }
       
        
    }
}

