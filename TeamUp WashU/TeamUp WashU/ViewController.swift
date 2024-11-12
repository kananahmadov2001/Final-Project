//
//  ViewController.swift
//  TeamUp WashU
//
//  Created by Samuel Gil on 11/10/24.
//

import UIKit

class ViewController:

    UIViewController {
    
    
    @IBOutlet weak var idField: UITextField!
    
    @IBOutlet weak var pswField: UITextField!
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Confirm", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    @IBAction func loginButton(_ sender: Any) {
        guard let id = idField.text,!id.isEmpty else{
            showAlert(message: "Enter ID")
            return
        }
        guard let psw = pswField.text, !psw.isEmpty else{
            showAlert(message: "Enter password")
            return
        }
        guard !id.isEmpty || !psw.isEmpty else{
            print("Enter account")
            return
        }
        
        if id == "test" && psw == "1234"{
                loginResultLabel.text = "Login Success"
            } else{
                loginResultLabel.text = "Login Fail"
            }
    }
    
    @IBOutlet weak var loginResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

