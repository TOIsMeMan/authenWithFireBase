//
//  homeViewController.swift
//  AUTHENWITHFIREBASE
//
//  Created by MacBook Pro on 26/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class homeViewController: UIViewController {
    
    var receivedData: String = ""
    var dataSender: String = ""
    var ID: String = ""
    var username: String = ""
    
    @IBOutlet weak var takeAPicture: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameTextLable: UILabel!
    @IBOutlet weak var uidTextLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSender = receivedData
        title = "Home"
        if let id = Auth.auth().currentUser?.uid, let userName = Auth.auth().currentUser?.email {
            ID = "ID: \(id)"
            username = "\(userName)"
        }

        uidTextLable.text = ID
        userNameTextLable.text = username
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
        } catch {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToCPWSegue" {
            if let CVC = segue.destination as? ChangePWViewController {
                CVC.receivedData = dataSender
            }
        }
    }
    
    @IBAction func changepw(_ sender: Any) {
        performSegue(withIdentifier: "homeToCPWSegue", sender: self)
    }
    
    @IBAction func takePicture(_ sender: Any) {
//MARK: upload picture
        if let image = imageView.image {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
            let storageRef = Storage.storage().reference()//tạo một tham chiếu đến thư mục gốc
            let imagesRef = storageRef.child("images")//tạo tham chiếu đến thư mục images
            let imageRef = imagesRef.child("photo.jpg")
            
            let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Loi roi con di: \(error)")
                    return
                } else {
                    
                }
            }
        } else {
//MARK: take a picture
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    func alertUploadPicture() {
        let alertController = UIAlertController(title: "Success",
                                                message: "Update picture successful!",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.takeAPicture.setTitle("Take a picture", for: .normal)
            self.imageView.image = nil
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension homeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.takeAPicture.setTitle("Update picture", for: .normal)
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
            return
        }
        imageView.image = image
    }
}
