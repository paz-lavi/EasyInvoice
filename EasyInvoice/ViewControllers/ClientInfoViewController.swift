//
//  ClientInfoViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 26/07/2021.
//

import UIKit

class ClientInfoViewController: UIViewController {

    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var addressEDT: UITextField!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var emailEDT: UITextField!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var phoneEDT: UITextField!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var nameEDT: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onSaveButtonClicked(_ sender: Any) {
        guard let uName = nameEDT.text else {
            showAlertDialog("clientNameRequired".localize)
            return
        }
        if uName.isEmpty{
            showAlertDialog("clientNameRequired".localize)
            return
        }
        
        let uAddress = addressEDT.text
        let uPhone = phoneEDT.text
        let uEmail = emailEDT.text
        let client = ClientModel(uName: uName, uAddress: uAddress, uPhone: uPhone, uEmail: uEmail)
        NotificationCenter.default.post(name: .clientInfoReady, object: nil, userInfo: ["client": client])
        showSucssesDialog("clientAddedSucssesfully".localize)

    }
}
