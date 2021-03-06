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
    static let monthlyReportURL = BaseURL + "/api/plan"
    static let homeMonthlyURL = BaseURL + "/api/plan/status"
    static let homeCategoryURL = BaseURL + "/api/plan/category"
    static let averageBudgetURL = BaseURL + "/api/plan/budget"
    
    
    /* 저축 */
    static let savingURL = BaseURL + "/api/savings"
    static let monthlySavingURL = BaseURL + "/api/savings/monthly"
    static let availableAmountURL = BaseURL + "/api/savings/saved"
    
    // 잔돈 모으기
    static let saveCoinURL = BaseURL + "/api/savings/changes"
    // 티끌 모으기
    static let saveTiggleURL = BaseURL + "/api/savings/coins"
    
    /* 예산 */
    static let updateBudgetURL = BaseURL + "/api/plan/budget"
    
}
