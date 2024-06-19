//
//  signupViewController.swift
//  AUTHENWITHFIREBASE
//
//  Created by MacBook Pro on 25/07/2023.
//

import UIKit
import FirebaseAuth

protocol signupVCDelegate: NSObjectProtocol {
    func signupSuccessful()
}

class signupViewController: UIViewController {

    var delegate: signupVCDelegate?
    
    let Remail = "tuancong146@gmail.com"
    let Rpassword = "1234567890."
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var CFPassWordTextField: UITextField!
    
    var NewPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Signup"
    }

    @IBAction func signup(_ sender: Any) {
        
        if (passwordTextField.text != CFPassWordTextField.text) {
            let alertController = UIAlertController(title: "Warning",
                                                    message: "Password is not the same",
                                                    preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            }

            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
        }
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]authResult, error in
            guard let strongSelf = self else {return}
            
            if error != nil {
                strongSelf.showLoginSuccessAlertI(erorr: "\(error?.localizedDescription)")
                print(String("\(error?.localizedDescription)"))
            } else {
                strongSelf.signupSuccessful()
            }
        }
    }
    
    func showLoginSuccessAlertI(erorr: String?) {
        
            let alertController = UIAlertController(title: "Warning",
                                                    message: erorr!,
                                                    preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            }

            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
    }
    
    func signupSuccessful() {
        let alertController = UIAlertController(title: "Success",
                                                message: "Signup successful!",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
