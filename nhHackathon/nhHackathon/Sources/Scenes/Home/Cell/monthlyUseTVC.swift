//
//  monthlyUseTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit
import Lottie

class monthlyUseTVC: UITableViewCell {

    // MARK: - Init
    
    
    @IBOutlet weak var monthlyUseView: UIView! {
        didSet {
            self.monthlyUseView.makeRounded(cornerRadius: 10)
            self.monthlyUseView.backgroundColor = .salmon
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var monthlyUseLabel: UILabel! {
        didSet {
        }
    }
    
    @IBOutlet weak var budgetLabel: UILabel! {
        didSet {
        }
    }
    
    @IBOutlet weak var availableLabel: UILabel! {
        didSet {
        }
    }
    
    @IBOutlet weak var animationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setAnimation()
        
        
    }

    // MARK: - Action
    
    @IBAction func monthlyUse(_ sender: Any) {
        print("CLICKED: 달 별 사용금액 버튼")
        
        let sb = UIStoryboard.init(name: "MonthUse", bundle: nil)
        
        guard let dvc = sb.instantiateViewController(withIdentifier: "MonthUseVC") as? MonthUseVC else {
            return
        }
        
        self.window?.rootViewController?.present(dvc, animated: true, completion: nil)
        
    }
    
    func setAnimation() {
        let lottieView = AnimationView(name: "main")
        
        animationView.addSubview(lottieView)
        
        lottieView.contentMode = .scaleAspectFill
        
        lottieView.frame = animationView.bounds
        
        // lottieView.play(fromProgress: 0, toProgress: 0.8, loopMode: .none, completion: nil)
        lottieView.play()
        lottieView.loopMode = .repeat(3)

    }
    
}
