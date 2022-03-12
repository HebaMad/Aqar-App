//
//  ProfileTarget.swift
//  Aqar
//
//  Created by heba isaa on 08/03/2022.
//

import Foundation
import Moya

enum ProfileApiTarget:TargetType{
    case signin(FullName:String,Country:String,PhoneNumber:String,Email:String,Password:String)
    case changePassword(email:String,password:String )
    case sendRecoveryCode(email:String)
    case profileDetails
    case getUserCar
    case getUserAqar
    case getUserAqarFav
    case getUserCarFav
    case removeFavCar(id:Int)
    case removeFavAqar(id:Int)
    case updateProfile(FullName:String,Country:String,PhoneNumber:String,Email:String,img:Data)
    case addFavCar(id:Int)
    case addFavAqar(id:Int)
    
    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)/User/")!
    }
    
    
    var path: String {
        
        switch self {
        case .signin:return "Create"
        case .changePassword:return "ChangePassword"
        case .sendRecoveryCode: return "SendRecoveryCode"
        case .profileDetails : return "GetUserDetail"
        case .getUserCar:return "GetUserCars"
        case .getUserAqar:return "GetUserRealStates"
        case .getUserAqarFav:return "GetUserRealStateFav"
        case .getUserCarFav:return "GetUserCarFav"
        case .removeFavCar:return "RemoveFavCar"
        case .removeFavAqar:return "RemoveFavRealEstate"
        case .updateProfile:return "updateProfile"
        case .addFavCar:return "AddFavCar"
        case .addFavAqar:return "AddFavRealEstate"
        }
        
    }
    
    var method: Moya.Method {
        switch self{
            
        case .updateProfile,.addFavCar,.addFavAqar:
            return .put
        case .removeFavCar,.removeFavAqar:
            return .delete
            
        case .sendRecoveryCode,.profileDetails,.getUserCar,.getUserAqar,.getUserAqarFav,.getUserCarFav:
            return .get
            
            
        case .signin,.changePassword:
            // change this later
            return Method.post
          

        
        }
    }
    
    var task: Task{
        switch self{
  
        case .profileDetails,.getUserCar,.getUserAqar,.getUserAqarFav,.getUserCarFav:
            return .requestPlain
        case .sendRecoveryCode:
                return .requestParameters(parameters: param, encoding: URLEncoding.queryString)

        case .signin,.changePassword,.removeFavCar,.removeFavAqar,.addFavCar,.addFavAqar:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)

        case .updateProfile(let FullName,let Country,let PhoneNumber,let Email,let img):
            
         let pngData = MultipartFormData(provider: .data(img), name: "Image", fileName: "images", mimeType: "image/png")
           let fullName = MultipartFormData(provider: .data(FullName.data(using: .utf8)!), name: "FullName")
            let country = MultipartFormData(provider: .data(Country.data(using: .utf8)!), name: "Country")
            let phoneNumber = MultipartFormData(provider: .data(PhoneNumber.data(using: .utf8)!), name: "PhoneNumber")
            let email = MultipartFormData(provider: .data(Email.data(using: .utf8)!), name: "Email")

            let multipartData = [pngData, fullName,country,phoneNumber,email]

                      return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .profileDetails,.getUserCar,.getUserAqar,.getUserAqarFav,.getUserCarFav,.removeFavCar,.removeFavAqar,.updateProfile,.addFavCar:
            
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
         
        case .addFavAqar(let id):
            return ["RealStateId":id]
        case .addFavCar(let id):
            return["CarId":id]
        case .updateProfile(let FullName,let Country,let PhoneNumber,let Email,let img):
            return["FullName":FullName,"Country":Country,"PhoneNumber":PhoneNumber,"Email":Email,"img":img]
        case .removeFavAqar(let id):
            return ["realStateId":id]
            
        case .removeFavCar(let id):
            return ["carId":id]
            
        case .signin(let FullName,let Country,let PhoneNumber,let Email,let Password):
            return ["FullName":FullName,"Country":Country,"PhoneNumber":PhoneNumber,"Email":Email,"Password":Password]
            
        case .changePassword(let email,let  password):
            return ["email":email,"password":password]

        default : return [:]
        }
       
        
    }
}

