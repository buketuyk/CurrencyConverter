//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by BUKET UYSAL KUYU on 6.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblUsd: UILabel!
    @IBOutlet weak var lblGbp: UILabel!
    @IBOutlet weak var lblCad: UILabel!
    @IBOutlet weak var lblTry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=9746d8969eca59e8e140d3697633fe97")
        
        let session = URLSession.shared
                
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2.
                if data != nil {
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.lblCad.text = "CAD: \(cad)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.lblGbp.text = "GBP: \(gbp)"
                                }
                                
                               // if let usd = rates["USD"] as? Double {
                               //     self.lblUsd.text = "USD: \(usd)"
                               // }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.lblTry.text = "TRY: \(turkish)"
                                }
                                
                                
                            }
                        }
                        
                        
                    } catch {
                       print("error")
                    }
                    
                }
                
                
            }
        }
        
        task.resume()
        
        }
}

