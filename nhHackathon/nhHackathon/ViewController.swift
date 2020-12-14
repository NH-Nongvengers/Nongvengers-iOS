//
//  ViewController.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(ViewController.showTutorial), with: nil, afterDelay: 1.5)
        
    }
    
    @objc func showTutorial() {
        
        let sb = UIStoryboard.init(name: "Home", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "PageVC") as! PageVC
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }

}

