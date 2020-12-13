//
//  SavingFinVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

/**TEST STRUCT*/


class SavingFinVC: UIViewController {

    //MARK: - Init
    
    var getData: [MonthlySave] = []
    
    @IBOutlet weak var monthlySaveLabel: UILabel!
    
    @IBOutlet weak var totalSaveLabel: UILabel!
    var totalAmount: String = ""
    
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
        
        getMonthlySaving()
        
        totalSaveLabel.text = DecimalWon(value: Int(totalAmount)!) + "원"
    }

    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        
        //self.dismiss(animated: true, completion: nil)
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        print("CLICKED: 저축하기 완료 VC")
    }
    
    func DecimalWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        return result
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
        return getData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savingMonthlyUseTVC") as! savingMonthlyUseTVC
        let monthString = getData[indexPath.row].period
        
        let startIdx: String.Index = monthString.index(monthString.startIndex, offsetBy: 5)
        let result = String(monthString[startIdx...])
        
        cell.monthLabel.text = result + "월"
        
        cell.useLabel.text = DecimalWon(value: Int(getData[indexPath.row].amount)!)
        
        return cell
        
    }
    
    
}

extension SavingFinVC {
    func getMonthlySaving() {
        SavingService.shared.getMonthlySaving() {
            [weak self]
            data in
            
            switch data {
                
            case .success(let res):
                
                let data = res as! [MonthlySave]
                
                self?.getData = res as! [MonthlySave]
                
                self?.monthlySaveLabel.text = "총 " + self!.DecimalWon(value: Int(data[0].amount)!) + "원"
                
                self?.monthlySaveTableView.dataSource = self
                self?.monthlySaveTableView.reloadData()
                
                
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
