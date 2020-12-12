//
//  HomeVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit
import Lottie

// MARK: TEST STRUCT
struct myUse {
    var category : String
    var left: Int
    var use: Int
    var image: String
}

class HomeVC: UIViewController {
    
    // MARK: - Init
    
    var myUseList : [myUse] = [myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: "")]
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var lastUseButton : UIButton! {
        didSet {
            self.lastUseButton.makeRounded(cornerRadius: 22.5)
            self.lastUseButton.backgroundColor = .salmon
            self.lastUseButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        }
    }
    
    // MARK: - Action
    
    @IBAction func testButton(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "SavingMain", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SavingMainVC") as! SavingMainVC
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func saving(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "Saving", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SavingVC") as! SavingVC
        
        present(vc, animated: true)
        
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.dataSource = self
        self.homeTableView.delegate = self
        
        //setPageViewController()
        
        
    }
    
}

// MARK: - Extension
/**TABLE VIEW*/
extension HomeVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return myUseList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dDayTVC") as! dDayTVC
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyUseTVC") as! monthlyUseTVC
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "myUseTitleTVC") as! myUseTitleTVC
            
            
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myUseTVC") as! myUseTVC
        
        
        return cell
        
    }
    
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3 {
            
            let magazineSB = UIStoryboard.init(name: "UseDetail", bundle: nil)
            
            guard let dvc = magazineSB.instantiateViewController(withIdentifier: "UseDetailVC") as? UseDetailVC else {
                return
            }
            
            print("CLICKED: 카테고리 Cell")
            
            dvc.modalPresentationStyle = .fullScreen
            
            self.present(dvc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5) {
            self.lastUseButton.transform = CGAffineTransform(translationX: self.lastUseButton.bounds.minX, y: 900)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) {
            self.lastUseButton.transform = CGAffineTransform.identity
        }
        print("scroll end!")
    }
    
}
