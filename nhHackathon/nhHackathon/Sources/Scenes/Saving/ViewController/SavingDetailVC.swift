//
//  SavingDetailVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class SavingDetailVC: UIViewController {
    
    //MARK: - Init
    
    var amount: String = ""
    
    var getData: [MonthlySave] = []
    
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    @IBOutlet weak var totalSavingLabel: UILabel!
    
    @IBOutlet weak var savingTableView: UITableView!
    
    var monthlySavingList : [Int] = [600000, 100000, 100000, 100000, 100000, 100000]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.savingTableView.delegate = self
        
        self.totalSavingLabel.text = amount + "원"
        
        getMonthlySaving()
        
    }
    
    //MARK: - Action
    
    @IBAction func close(_ sender: Any) {
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK: - Extension
extension SavingDetailVC: UITableViewDataSource, UITableViewDelegate {
    
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
        return getData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savingAfterSavingTVC") as! savingAfterSavingTVC
        
        let get = getData[indexPath.row]

        let startIdx: String.Index = get.period.index(get.period.startIndex, offsetBy: 5)
        let result = String(get.period[startIdx...])

        cell.monthLabel.text = result + "월"
        cell.useLabel.text = DecimalWon(value: Int(get.amount)!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let sb = UIStoryboard.init(name: "MonthUse", bundle: nil)
        
        guard let dvc = sb.instantiateViewController(withIdentifier: "MonthUseVC") as? MonthUseVC else {
            return
        }
        
        print("CLICKED: 절약 후 저축금액 Cell")
        
        dvc.modalPresentationStyle = .fullScreen
        
        self.present(dvc, animated: true)
    }
}

extension SavingDetailVC {
    func getMonthlySaving() {
        SavingService.shared.getMonthlySaving() {
            [weak self]
            data in
            
            switch data {
            
            case .success(let res):
                
                
                self?.getData = res as! [MonthlySave]
                
                print(self!.getData)
                print(res)
                self?.savingTableView.reloadData()
                self?.savingTableView.dataSource = self
                
            case .requestErr( _):
                print(".requestErr")
                break
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print(".serverErr")
            case .networkFail:
                print(".networkFail")
            case .dbErr:
                print("db error")
                
            }
        }
    }
    
    
    
}
