//
//  AuthTarget.swift
//  Aqar
//
//  Created by heba isaa on 07/03/2022.
//

import Foundation
import Moya

enum AuthApiTarget:TargetType{
    case login(email:String,password:String )
    case sendRecoveryCode(email:String)
    

    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)/Auth/")!
    }
    
    
    var path: String {
        switch self {
        case .login:return ""
        case .sendRecoveryCode: return "SendRecoveryCode"
    
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .sendRecoveryCode:
            return .get
        case .login:
            // change this later
            return Method.post
          

        
        }
    }
    
    var task: Task{
        switch self{
  
            
        case .sendRecoveryCode:
                return .requestParameters(parameters: param, encoding: URLEncoding.queryString)

        case .login:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)


        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .sendRecoveryCode:
            
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
     
            
      
        case .login(let email,let  password):
            return ["email":email,"password":password]

        default : return [:]
        }
       
        
    }
}

