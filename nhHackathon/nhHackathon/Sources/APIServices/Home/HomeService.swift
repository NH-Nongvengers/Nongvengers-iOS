//
//  HomeService.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
import Alamofire

struct HomeService {
    static let shared = HomeService()
    
    //MARK: 홈화면
    func getHomeMonthly(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.homeMonthlyURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseObject<monthlyBudget>.self, from: value)
                                    
                                    print("Success")
                                    completion(.success(result.data!))
                                    
                                } catch {
                                    print("pathErr")
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                                print(".pathErr")
                            case 600:
                                completion(.serverErr)
                                print("serverErr")
                            default:
                                print("default")
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
    
    func getHomeCategory(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.homeCategoryURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseArray<Category>.self, from: value)
                                    
                                    print("Success")
                                    completion(.success(result.data))
                                    
                                } catch {
                                    print("pathErr?")
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                                print(".pathErr??")
                            case 600:
                                completion(.serverErr)
                                print("serverErr")
                            default:
                                print("default")
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
    
    /* GET: 3개월 평균 예산 조회 */
    func getAverage(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.averageBudgetURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    
                                    let result = try decoder.decode(ResponseObject<AverageData>.self, from: value)
                                    
                                    print("Success")
                                    completion(.success(result.data!))
                                    
                                } catch {
                                    print("pathErr")
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                                print(".pathErr")
                            case 600:
                                completion(.serverErr)
                                print("serverErr")
                            default:
                                print("default")
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
