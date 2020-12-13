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
