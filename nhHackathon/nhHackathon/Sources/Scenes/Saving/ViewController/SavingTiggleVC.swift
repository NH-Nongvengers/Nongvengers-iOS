//
//  SavingTiggleVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class SavingTiggleVC: UIViewController {

    
    @IBOutlet weak var tiggleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tiggleTableView.dataSource = self
    }

    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension SavingTiggleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tiggleHistoryTVC") as! monthlyHistoryTVC
        
        
        return cell
    }
    
    
}
