//
//  SettingNetworkable.swift
//  Aqar
//
//  Created by heba isaa on 10/03/2022.
//

import Foundation
import Foundation
import Moya
protocol SettingNetworkable:Networkable  {
    
func aboutus(completion: @escaping (Result<BaseResponse<AppSetting>, Error>) -> ())
    func contactUs(completion: @escaping (Result<BaseResponse<AppSetting>, Error>) -> ())

    

}
class SettingManager:SettingNetworkable{
 
 
  
   var provider: MoyaProvider<SettingApiTarget> = MoyaProvider<SettingApiTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: SettingManager = {
       let generalActions = SettingManager()
       return generalActions
   }()
    
    func aboutus(completion: @escaping (Result<BaseResponse<AppSetting>, Error>) -> ()) {
        request(target: .AboutUs, completion: completion)
    }
    
    func contactUs(completion: @escaping (Result<BaseResponse<AppSetting>, Error>) -> ()) {
        request(target: .contactus, completion: completion)
    }
    

}
