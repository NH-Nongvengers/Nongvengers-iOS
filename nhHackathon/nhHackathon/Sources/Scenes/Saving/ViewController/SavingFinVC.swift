//
//  SavingFinVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

/**TEST STRUCT*/

struct MonthlyUse {
    var month: Int
    var usage: Int
}

class SavingFinVC: UIViewController {

    //MARK: - Init
    
    @IBOutlet weak var monthlySaveLabel: UILabel!
    
    @IBOutlet weak var totalSaveLabel: UILabel!
    
    
    var monthlyUseList: [MonthlyUse] = [MonthlyUse(month: 12, usage: 600000), MonthlyUse(month: 12, usage: 600000), MonthlyUse(month: 11, usage: 600000), MonthlyUse(month: 12, usage: 600000), MonthlyUse(month: 10, usage: 600000), MonthlyUse(month: 9, usage: 600000)]
    
    @IBOutlet weak var monthlySaveTableView: UITableView! {
        didSet {
            self.monthlySaveTableView.dataSource = self
            self.monthlySaveTableView.delegate = self
        }
    }
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            self.finishButton.makeRounded(cornerRadius: 22.5)
            self.finishButton.backgroundColor = .salmon
            self.finishButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        }
    }
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        
        //self.dismiss(animated: true, completion: nil)
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        print("CLICKED: 저축하기 완료 VC")
    }
    
    
}

extension SavingFinVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "2020년"
        label.textColor = .veryLightPink
        label.frame = CGRect(x: 158, y: 16, width: 59, height: 27)
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyUseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savingMonthlyUseTVC") as! savingMonthlyUseTVC
        
        let data = monthlyUseList[indexPath.row]
        
        cell.monthLabel.text = String(data.month) + "월"
        
        cell.useLabel.text = String(data.usage)
        
        return cell
        
    }
    
    
}
