//
//  SavingCoinVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class SavingCoinVC: UIViewController {

    @IBOutlet weak var leftTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leftTableView.dataSource = self
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension SavingCoinVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savingLeftTVC") as! savingLeftTVC
        
        return cell
    }
    
    
}
