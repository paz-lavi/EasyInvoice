//
//  SignatureViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 26/07/2021.
//

import UIKit
import SignaturePad
class SignatureViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var signaturePad: SignaturePad!
    @IBOutlet weak var clearBTN: UIButton!
    
    @IBOutlet weak var signLBL: UILabel!
    @IBOutlet weak var continueBTN: UIButton!
    
     var items : [InvoiceItem] = []
     var clientModel : ClientModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        signaturePad.delegate = self

        // Do any additional setup after loading the view.
    }

    @IBAction func onContinueButtonClicked(_ sender: Any) {
        guard let sig =  getSignature() else{
            showAlertDialog("pleaseSign".localize)
            return
        }
        let gen = InvoiceGenerator(items: items, clientModel: clientModel!, signature: sig)
        gen.delegate = self
        showSucssesDialog("generatingInvoicePleaseWait".localize)
        gen.generateInvoice()

    }
    @IBAction func onClearButtonClicked(_ sender: Any) {
        clearSignature()
    }
}


extension  SignatureViewController: SignaturePadDelegate{
    func didStart() {
        
    }
    
    func didFinish() {

    }
    
    private func clearSignature(){
        signaturePad.clear()
    }
    private func getSignature() -> UIImage?{
        guard let signature = signaturePad.getSignature() else {
            return nil        }
        return signature
    }
    
}

extension SignatureViewController : InvoiceGeneratorDelegate{
    func onInvoiceReady(_ url: String) {
        shareLink(url: url)
    }
    
    func onError(_ error: Error?) {
        showAlertDialog("failedToGenerateInvoice".localize)
    }
    
    
}
