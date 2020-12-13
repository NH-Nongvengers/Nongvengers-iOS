//
//  SavingTiggleVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class SavingTiggleVC: UIViewController {

    //MARK: - Init
    @IBOutlet weak var tiggleTableView: UITableView!
    
    @IBOutlet weak var autoSaveButton: UIButton! {
        didSet {
            self.autoSaveButton.setBorder(borderColor: .salmon, borderWidth: 1)
            self.autoSaveButton.makeRounded(cornerRadius: 15)
            self.autoSaveButton.tintColor = .salmon
        }
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tiggleTableView.dataSource = self
    }

    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func autoSave(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "AutoSave", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SavingAutoVC") as! SavingAutoVC
        
        present(vc, animated: true)
        
    }
    
    
}

//MARK: - Extension
extension SavingTiggleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tiggleHistoryTVC") as! monthlyHistoryTVC
        
        
        return cell
    }
    
    
}
