//
//  AuthNetworkable.swift
//  Aqar
//
//  Created by heba isaa on 07/03/2022.
//

import Foundation
import Moya
protocol AuthNetworkable:Networkable  {
    
    func signin(FullName:String,Country:String,PhoneNumber:String,Email:String,Password:String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())


}
class AuthManager:AuthNetworkable{
 
    


   var provider: MoyaProvider<AuthApiTarget> = MoyaProvider<AuthApiTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: AuthManager = {
       let generalActions = AuthManager()
       return generalActions
   }()
   typealias targetType = AuthApiTarget

   
    func signin(FullName: String, Country: String, PhoneNumber: String, Email: String, Password: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .signin(FullName: FullName, Country: Country, PhoneNumber: PhoneNumber, Email: Email, Password: Password), completion: completion)
    }
}
