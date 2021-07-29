//
//  ReportsViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 21/07/2021.
//

import UIKit

class ReportsViewController: UIViewController {

    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLBL.localizeLable()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
}


// MARK: Table View (records)
extension ReportsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //1 - headers , 14 - total
        return 14
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profitCell", for: indexPath) as! ProfitTableViewCell
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ =  tableView.cellForRow(at: indexPath) as! ProfitTableViewCell
      
        
    }
    
}

