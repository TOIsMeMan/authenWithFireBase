//
//  loginViewController.swift
//  AUTHENWITHFIREBASE
//
//  Created by MacBook Pro on 25/07/2023.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController, signupVCDelegate {

    var dataSender: String = ""
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var passowordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
// MARK: Login
    
    @IBAction func login(_ sender: Any) {
        guard let email = EmailTextField.text, let password = passowordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if error != nil {
                strongSelf.success(title: "Warning", message: "\(String(describing: error?.localizedDescription))")
                print("\(String(describing: error?.localizedDescription))")
            } else {
                
                if let password = strongSelf.passowordTextField.text {
                    strongSelf.dataSender = password
                }
                
                strongSelf.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToHomeSegue" {
            if let homeVC = segue.destination as? homeViewController {
                homeVC.receivedData = dataSender
            }
        }
    }
    
//  MARK: Forgot password
    
    @IBAction func forgetPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Forgot password", message: "Enter your email", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        let resetAction = UIAlertAction(title: "Reset password", style: .default) { [weak self] (_) in
            guard let weak = self else {return}
            
            if let email = alert.textFields?.first?.text {
                weak.resetPassword(email: email)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print("loi roi cdl")
            } else {
                self.success(title: "Success", message: "Please check your email!")
            }
        }
    }
    
//  MARK: Alert
    
    func success(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
//  MARK: Delegate
    
    func signupSuccessful() {
        let alertController = UIAlertController(title: "Success",
                                                message: "Signup successful!",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}


