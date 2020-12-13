//
//  String+Extension.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation

extension String {
    var insertComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return self
    }
}
