//
//  MonthUseVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class MonthUseVC: UIViewController {

    
    //MARK: - Init
    var categoryUseList : [myUse] = [myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: "")]
    
    @IBOutlet weak var reportTableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reportTableView.dataSource = self
    }
    
    //MARK: - Action
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Extension
/**TABLE VIEW*/
extension MonthUseVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return categoryUseList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "overTitleTVC") as! myUseTitleTVC
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "overUseTVC") as! categoryUseTVC
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryUseTVC") as! myUseTitleTVC
            
            
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCategoryUseTVC") as! myUseTVC
        
        
        return cell
        
    }
    
}

