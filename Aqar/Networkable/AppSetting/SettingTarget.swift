//
//  SettingTarget.swift
//  Aqar
//
//  Created by heba isaa on 10/03/2022.
//

import Foundation
import Foundation
import Moya

enum SettingApiTarget:TargetType{
    case AboutUs
    case contactus
    

    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)/AppSetting/")!
    }
    
    
    var path: String {
        switch self {
        case .AboutUs:return "GetAboutUs"
        case .contactus: return "GetContactUs"
    
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .AboutUs,.contactus:
            return .get


        
        }
    }
    
    var task: Task{
        switch self{
  
        case .AboutUs,.contactus:
            return .requestPlain

        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .AboutUs,.contactus:
            return ["Accept":"application/json"]
            
        default:return ["Accept":"application/json"]
        }
        
        
    }
    var param: [String : Any]{
        
        
        switch self {
     
 
        default : return [:]
        }
       
        
    }
}

