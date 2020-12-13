//
//  MonthlyBudget.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
import UIKit

struct monthlyBudget: Codable {
    let month: Int
    let dDay: Int
    let budget: Int
    let amountUsed: Int
    let balance: Int
}

struct Category: Codable {
    let categoryIdx: Int
    let budget: Int
    let balance: Int
    let categoryName: String
    let percent: Int
}

struct ResponseReport: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Report?
}

struct Report: Codable {
    let summary: Summary
    let overConsumption, result: [OverConsumption]
}

struct OverConsumption: Codable {
    let categoryIdx: Int
    let categoryName: String
    let budget: Int
    let consumption: Int?
    let percent: Int
    let balance: Int?
}

struct Summary: Codable {
    let month, budget, amountUsed, balance: Int
}

/* 저축 */
struct SaveMain: Codable {
    let sum, saved, changes, coin: Int
}
