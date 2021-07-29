//
//  PDFViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 29/07/2021.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var shareBTN: UIBarButtonItem!
    @IBOutlet weak var pdfView: PDFView!
     var invoice : InvoiceModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPDF()
        // Do any additional setup after loading the view.
    }
    
    
    private func downloadPDF(){
        if let url = invoice?.invoiceURL{
            guard let url = URL(string: url) else {return}
           do{
               let data = try Data(contentsOf: url)
               let pdfDOC = PDFDocument(data: data)
               pdfView.displayMode = .singlePageContinuous
               pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               pdfView.displaysAsBook = true
               pdfView.displayDirection = .vertical
               pdfView.document = pdfDOC
               pdfView.autoScales = true
               pdfView.maxScaleFactor = 4.0
               pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
           }catch let err{
               print(err.localizedDescription)
           }
            
        }
       }
    
    @IBAction func onShareButtonClicked(_ sender: Any) {
        if invoice != nil{
            shareLink(url: invoice!.invoiceURL )
        }}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
