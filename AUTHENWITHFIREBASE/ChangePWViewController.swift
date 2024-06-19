//
//  ChangePWViewController.swift
//  AUTHENWITHFIREBASE
//
//  Created by MacBook Pro on 28/07/2023.
//

import UIKit
import Firebase

class ChangePWViewController: UIViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    var receivedData: String = ""
    var oldPassword: String = ""
    var newPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change password"
    }
    
    @IBAction func changePassWord(_ sender: Any) {
        if let password = newPasswordTextField.text {
            newPassword = password
        }
        
        if let password = oldPasswordTextField.text {
            oldPassword = password
        }
        
        if oldPassword == receivedData {
            Auth.auth().currentUser?.updatePassword(to: newPassword)
            successful()
        } else {
            erorr()
        }
    }
    
    func erorr() {
        let alertController = UIAlertController(title: "Warning",
                                                message: "Erorr",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func successful() {
        let alertController = UIAlertController(title: "Success",
                                                message: "Change password successful!",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}
