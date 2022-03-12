//
//  ProfileNetworkable.swift
//  Aqar
//
//  Created by heba isaa on 08/03/2022.
//

import Foundation
import Moya
protocol ProfileNetworkable:Networkable  {
    
    func signin(FullName:String,Country:String,PhoneNumber:String,Email:String,Password:String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func changePassword(email:String,password:String , completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func sendRecoveryCode(email:String , completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func profileDetails(completion: @escaping (Result<BaseResponse<ProfileModel>, Error>)-> ())
    func getUserCar( completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func getUserAqar( completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func getUserAqarFav( completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func getUserCarFav( completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func removeFavCar(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func removeFavAqar(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func updateProfile(FullName:String,Country:String,PhoneNumber:String,Email:String,img:Data, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func addFavCar(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func addFavAqar(id:Int, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    
    
}
class ProfileManager:ProfileNetworkable{
 
  
   var provider: MoyaProvider<ProfileApiTarget> = MoyaProvider<ProfileApiTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: ProfileManager = {
       let generalActions = ProfileManager()
       return generalActions
   }()
   typealias targetType = ProfileApiTarget

    func signin(FullName: String, Country: String, PhoneNumber: String, Email: String, Password: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .signin(FullName: FullName, Country: Country, PhoneNumber: PhoneNumber, Email: Email, Password: Password), completion: completion)
    }
    func changePassword(email: String, password: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .changePassword(email: email, password: password), completion: completion)
    }
    func sendRecoveryCode(email: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .sendRecoveryCode(email: email), completion: completion)
    }
    
    func profileDetails(completion: @escaping (Result<BaseResponse<ProfileModel>, Error>) -> ()) {
        request(target: .profileDetails, completion: completion)
    }
    func getUserCar(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getUserCar, completion: completion)
    }
    func getUserAqar(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getUserAqar, completion: completion)
    }
    func getUserAqarFav(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getUserAqarFav, completion: completion)
    }
    func getUserCarFav(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getUserCarFav, completion: completion)
    }
    
    func removeFavCar(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .removeFavCar(id: id), completion: completion)
    }
    
    func removeFavAqar(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .removeFavAqar(id: id), completion: completion)
    }
    
    func updateProfile(FullName: String, Country: String, PhoneNumber: String, Email: String, img: Data, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateProfile(FullName: FullName, Country: Country, PhoneNumber: PhoneNumber, Email: Email, img: img), completion: completion)
    }
    func addFavCar(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .addFavCar(id: id), completion: completion)
    }
    
    func addFavAqar(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .addFavAqar(id: id), completion: completion)
    }
    
 
   

}
