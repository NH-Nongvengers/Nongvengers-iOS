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
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let total: String
}


