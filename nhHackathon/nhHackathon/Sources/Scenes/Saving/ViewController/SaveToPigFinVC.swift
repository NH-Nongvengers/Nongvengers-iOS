//
//  SaveToPigFinVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class SaveToPigFinVC: UIViewController {

    //MARK: - Init
    
    @IBOutlet weak var announceLabel: UILabel! {
        didSet {
            
            let attributedString = NSMutableAttributedString(string: "저금통이 채워졌습니다!", attributes: [
              .font: UIFont(name: "SpoqaHanSansNeo-Bold", size: 20.0)!,
              .foregroundColor: UIColor.black
            ])
            attributedString.addAttribute(.foregroundColor, value: UIColor.salmon, range: NSRange(location: 0, length: 3))
            
            self.announceLabel.attributedText = attributedString
        }
    }
    
    
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var announceView: UIView! {
        didSet {
            self.announceView.backgroundColor = .veryLightPinkThree
            self.announceView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.announceView.roundTopCorners(cornerRadius: 10)
        }
    }
    
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            self.finishButton.backgroundColor = .salmon
            self.finishButton.makeRounded(cornerRadius: 22.5)
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
