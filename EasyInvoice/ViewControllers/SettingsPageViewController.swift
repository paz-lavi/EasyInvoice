//
//  SettingsPageViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 23/07/2021.
//

import UIKit
import FirebaseAuth
class SettingsPageViewController: UIViewController {

    @IBOutlet weak var accountLBL: PaddingLabel!
    @IBOutlet weak var invoiceLBL: PaddingLabel!
    @IBOutlet weak var invoiceBtn: UIButton!
    @IBOutlet weak var taxBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var subscriptionBtn: UIButton!
    @IBOutlet weak var regionBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
    }
    
    private func localize(){
        invoiceBtn.localizeTitle()
        taxBtn.localizeTitle()
        businessBtn.localizeTitle()
        logoutBtn.localizeTitle()
        subscriptionBtn.localizeTitle()
        regionBtn.localizeTitle()
        invoiceLBL.localizeLable()
        accountLBL.localizeLable()
    }

    @IBAction func logoutClicked(_ sender: Any) {
        do{
        try Auth.auth().signOut()
            navigateToHomePage()
        }catch{
            print(error.localizedDescription)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: My Logic
extension SettingsPageViewController{
    private func navigateToHomePage(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "splashScreen") as! ViewController
//        nextViewController.modalPresentationStyle = .fullScreen
//        nextViewController.modalTransitionStyle = .crossDissolve
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
            }
}
