//
//  ResposeType.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
import UIKit

struct ResponseArray<T: Codable>: Codable  {
    let status: Int
    let success: Bool
    let message: String
    let data: [T]?
}

struct ResponseObject<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: T?
}

struct ResponseString: Codable {
    let status: Int
    let message: String
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case status = "status_idx"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(DataClass.self, forKey: .data)) ?? nil
    }
}

struct DataClass: Codable {
    let token: String
}
