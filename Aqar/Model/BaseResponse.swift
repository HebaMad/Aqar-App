//
//  BaseResponse.swift
//  Rakwa
//
//  Created by moumen isawe on 29/10/2021.
//

import Foundation
struct BaseResponse<T:Decodable>: Decodable {
    let status: Bool
//    let statusCode: Int
    let message: String
//    let errors: [ErrorElement]?
    let data: T?

    enum CodingKeys: String, CodingKey {
        case status
//        case statusCode = "status_code"
        case message
//        case errors

        case  data
    }
}

// MARK: - Error
struct ErrorElement: Codable {
    let message: String
}
