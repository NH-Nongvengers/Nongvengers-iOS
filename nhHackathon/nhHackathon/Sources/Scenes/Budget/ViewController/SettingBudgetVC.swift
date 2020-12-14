//
//  SettingBudgetVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

class SettingBudgetVC: UIViewController {

    //MARK: - Init
    
    var averageData: AverageData?
    var budgetList: [SumBudgetCategory] = []
    
    @IBOutlet weak var topContainView: UIView! {
        didSet {
            self.topContainView.backgroundColor = .salmon
        }
    }
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var averageAmountLabel: UILabel!
    
    @IBOutlet weak var averageAmount: UILabel!
    
    
    @IBOutlet weak var oneMonthAmountLabel: UILabel!
    
    @IBOutlet weak var oneMonthAmount: UILabel!
        
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            self.finishButton.makeRounded(cornerRadius: 13.5)
            self.finishButton.setBorder(borderColor: .white, borderWidth: 2)
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryCollectionView.dataSource = self
        
        getAverageBudget()
        
    }
    
    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finish(_ sender: Any) {
        SavingService.shared.changeBudget(0, 0, 0, 0, 0, 0, 0, 0, 0){ data in
            switch data {

            case .success :
                print("예산 업데이트 하기 성공")
                
                print("=== PUT: 예산 업데이트 ===")
                
                self.dismiss(animated: true, completion: nil)
                
            case .requestErr(let msg):
                print("절약 저축 requestErr")
                print(msg)
            case .pathErr:
                print("here pathErr")
            case .serverErr:
                print("절약 저축 serverErr")
            case .networkFail:
                print("절약 저축 networkFail")
            case .dbErr:
                print("절약 저축 dbErr")
            }
        }
    }
    
}

//MARK: - Extension
extension SettingBudgetVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return budgetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "budgetCVC", for: indexPath) as! budgetCVC
        
        let budget = budgetList[indexPath.row]
        
        cell.average.text = DecimalWon(value: budget.categoryAverageBudget) + "원"
        cell.image.image = UIImage(named: categoryImage[budget.categoryIdx - 1])
        cell.category.text = budget.categoryName
        
        cell.textField.text = DecimalWon(value: budget.categoryAverageBudget)
        
        return cell
    }
}

extension SettingBudgetVC {
    func getAverageBudget(){
        HomeService.shared.getAverage() {
            [weak self]
            data in
            
            switch data {
                
            case .success(let res):
                
                self?.averageData = res as? AverageData
                
                self?.averageAmount.text = self!.DecimalWon(value: (self?.averageData!.averageBudget)!) + "원"
                self?.oneMonthAmount.text = self!.DecimalWon(value: (self?.averageData!.averageTotal)!) + "원"
                
                self?.budgetList = (self?.averageData!.sumBudgetCategory)!
                
                self?.categoryCollectionView.dataSource = self
                self?.categoryCollectionView.reloadData()
                
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
