//
//  NetworkResult.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
// 네트워크 상태의 5가지 결과 (성공, 요청 에러, 경로 에러, 서버 에러, 통신 실패)
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
    case dbErr
}
