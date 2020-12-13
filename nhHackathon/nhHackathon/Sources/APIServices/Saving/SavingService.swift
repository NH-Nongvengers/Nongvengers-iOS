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
}
