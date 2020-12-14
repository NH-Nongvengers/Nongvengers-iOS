//
//  SplashVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/14.
//

import UIKit

class SplashViewController: UIViewController {
    
    let img = UIImageView()
    
    // MARK: - Action
    func overSplash() {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
              let homeVC = UIStoryboard(name: "Home", bundle: nil)
                .instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else { return }
        
        keyWindow.rootViewController = homeVC
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        img.image = UIImage(named: "imgSplash")
        
        self.view.addSubview(img)
        
        self.view.center = img.center
        
    }
}
