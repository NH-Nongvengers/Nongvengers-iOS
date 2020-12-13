//
//  ReportService.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
import Alamofire

struct ReportService {
    
    static let shared = ReportService()
    
    func getReportDetail(planIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.monthlyReportURL + "/\(planIdx)"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
        ]
        
        let paramaters : Parameters = [
            "planIdx" : planIdx
        ]
        
        Alamofire.request(URL, method: .get, parameters: paramaters, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                // 통신 성공
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseObject<Report>.self, from: value)
                                    print("달 별 리포트 Success")
                                    completion(.success(result.data))
                                    
                                } catch {
                                    print("달 별 리포트 path Err")
                                    completion(.pathErr)
                                }
                            case 400, 401:
                                completion(.pathErr)
                                print("달 별 리포트 path Err")
                            case 600:
                                completion(.serverErr)
                                print("달별 리포트 server err")
                            default:
                                
                                break
                            }
                        }
                    }
                    break
                    
                // 통신 실패
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
}
