//
//  String+Extension.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import Foundation
import UIKit

extension UIViewController {
    
    func DecimalWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        return result
    }
    
}

extension UITableViewCell {
    func changeToWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        return result
    }
}
