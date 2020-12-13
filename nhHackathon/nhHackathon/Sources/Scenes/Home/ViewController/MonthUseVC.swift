//
//  MonthUseVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class MonthUseVC: UIViewController {

    
    //MARK: - Init
    var categoryUseList : [String] = [""]
    
    var report: Report?
    
    
    @IBOutlet weak var reportTableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reportTableView.dataSource = self
        
        /* Network */
        ReportService.shared.getReportDetail(planIdx: 1) {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data{
            case .success(let res) :
                self.report = res as? Report
                
                print("==== 리포트 상세 통신 ====")
                
                print(self.report?.result)
                print(self.report?.summary)
                print(self.report?.overConsumption)
                
                
            case .requestErr(_):
                print("request err")
            case .pathErr:
                print("path err")
            case .serverErr:
                print("server err")
            case .networkFail:
                print("network err")
            case .dbErr:
                print("db err")
            }
        }
        
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

extension MonthUseVC {
}
