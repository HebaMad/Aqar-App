//
//  AuthNetworkable.swift
//  Aqar
//
//  Created by heba isaa on 07/03/2022.
//

import Foundation
import Moya
protocol AuthNetworkable:Networkable  {
    
    func login(email:String,password:String , completion: @escaping (Result<BaseResponse<loginModel>, Error>) -> ())
    func sendRecoveryCode(email:String, completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())

}
class AuthManager:AuthNetworkable{
 
  


   var provider: MoyaProvider<AuthApiTarget> = MoyaProvider<AuthApiTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: AuthManager = {
       let generalActions = AuthManager()
       return generalActions
   }()
   typealias targetType = AuthApiTarget

    func login(email: String, password: String, completion: @escaping (Result<BaseResponse<loginModel>, Error>) -> ()) {
        request(target: .login(email: email, password: password), completion: completion)
    }
    func sendRecoveryCode(email: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .sendRecoveryCode(email: email), completion: completion)
    }

}
