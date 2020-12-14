//
//  SavingService.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
import Alamofire

struct SavingService {
    
    static let shared = SavingService()
    //GET: 저금 메인 탭 정보 가져오기
    func getMainSaving(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.savingURL
        
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
                                    
                                    let result = try decoder.decode(ResponseObject<SaveMain>.self, from: value)
                                    
                                    print("Success")
                                    completion(.success(result.data))
                                    
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
    
    //GET: 월별 절약 저축 금액 확인하기
    func getMonthlySaving(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.monthlySavingURL
        
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
                                    
                                    let result = try decoder.decode(ResponseArray<MonthlySave>.self, from: value)
                                    
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
    
    /* 티끌 모으기 */
    func getTiggle(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.saveTiggleURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
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
                                    let result = try decoder.decode(ResponseObject<Tiggle>.self, from: value)
                                    print("티끌 상세 내역 Success")
                                    completion(.success(result.data))
                                    
                                } catch {
                                    print("티끌 상세 내역 path Err")
                                    completion(.pathErr)
                                }
                            case 400, 401:
                                completion(.pathErr)
                                print("내 문제: 티끌 상세 내역 path Err")
                            case 600:
                                completion(.serverErr)
                                print("티끌 상세 내역 server err")
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
    
    func getLeft(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.saveCoinURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
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
                                    let result = try decoder.decode(ResponseObject<Coin>.self, from: value)
                                    print("티끌 상세 내역 Success")
                                    completion(.success(result.data))
                                    
                                } catch {
                                    print("티끌 상세 내역 path Err")
                                    completion(.pathErr)
                                }
                            case 400, 401:
                                completion(.pathErr)
                                print("내 문제: 티끌 상세 내역 path Err")
                            case 600:
                                completion(.serverErr)
                                print("티끌 상세 내역 server err")
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
    
    
    func getAvailableSaving(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.availableAmountURL
        
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
                                    
                                    let result = try decoder.decode(ResponseArray<Amount>.self, from: value)
                                    
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
    
    //POST: 저축하기
    func saveSaving(_ amount: String, _ transactionType: Int, completion: @escaping(NetworkResult<Any>) -> Void){
        
        let URL = APIConstants.savingURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body: Parameters = [
            "amount" : amount,
            "transactionType" : transactionType
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData(){
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        
                        switch status {
                        case 200, 201:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(ResponseString.self, from: value)
                                print(result)
                                completion(.success(result.data))
                            }
                            catch {
                                completion(.pathErr)
                                print(error.localizedDescription)
                            }
                        case 403:
                            completion(.requestErr("duplicated"))
                        case 400:
                            completion(.requestErr("입력값에 Null Value"))
                        case 500:
                            completion(.serverErr)
                            
                        default:
                            print(status)
                        }// switch
                    }// iflet
                }
                break
                
            // 통신 실패 - 네트워크 연결
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
                // .networkFail이라는 반환 값이 넘어감
                break
            }
        }
    }
    
    
    //PUT: 저축하기
    func changeBudget(_ food: Int, _ shopping: Int, _ life: Int, _ drink: Int, _ beauty: Int, _ cafe: Int, _ trip: Int, _ communication: Int, _ etc: Int, completion: @escaping(NetworkResult<Any>) -> Void){
        
        let URL = APIConstants.updateBudgetURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body: Parameters = [
            "food" : food,
            "shopping": shopping,
            "life": life,
            "drink": drink,
            "beauty": beauty,
            "cafe": cafe,
            "trip": trip,
            "communication": communication,
            "etc": etc
        ]
        
        Alamofire.request(URL, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header).responseData(){
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        
                        switch status {
                        case 200, 201:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(ResponseArray<String>.self, from: value)
                                print(result)
                                completion(.success(result.message))
                            }
                            catch {
                                completion(.pathErr)
                                print(error.localizedDescription)
                            }
                        case 403:
                            completion(.requestErr("duplicated"))
                        case 400:
                            completion(.requestErr("입력값에 Null Value"))
                        case 500:
                            completion(.serverErr)
                            
                        default:
                            print("is it here?")
                            print(status)
                        }// switch
                    }// iflet
                }
                break
                
            // 통신 실패 - 네트워크 연결
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
                // .networkFail이라는 반환 값이 넘어감
                break
            }
        }
    }
}
