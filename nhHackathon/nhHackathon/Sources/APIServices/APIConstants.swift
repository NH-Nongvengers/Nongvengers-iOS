//
//  APIConstants.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation

struct APIConstants {
    static let BaseURL = "http://3.35.251.129:3000"
    
    /* 홈 */
    static let homeMonthlyURL = BaseURL + "/api/plan/category"
    static let homeCategoryURL = BaseURL + "/api/plan/category"
    
    
    /* 저축 */
    static let savingURL = BaseURL + "/api/savings"
    static let monthlySavingURL = BaseURL + "/api/savings/monthly"
    
}
