//
//  SelectPictureViewController.swift
//  CatChat
//
//  Created by Vu Duong on 9/7/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var imagePicker : UIImagePickerController?
    var imageAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
    }
    @IBAction func selectPhotoTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .photoLibrary
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageAdded = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        if let message = messageTextField.text {
            if imageAdded && message != "" {
                // Segues to next view controller
                let imageFolder = Storage.storage().reference().child("images")
                                                // firebase folder name ^^^^
                // Convert image to data
                if let image = imageView.image {
                    if let imageData =  UIImageJPEGRepresentation(image, 0.1) {
                        // Gives each picture a unique ID                Upload and save data
                        imageFolder.child("\(NSUUID().uuidString).jpeg").putData(imageData, metadata: nil) { (metadata, error) in
                            if let error = error {
                                self.presentAlert(alert: error.localizedDescription)
                            } else {
                                // Segue to next controller
                                
                            }
                        }
                    }
                }
            } else {
                // We are missing somthing
                presentAlert(alert: "You must provide an image and a message")
            }
        }
    }
    
    func presentAlert(alert : String) {
        let alertVC =  UIAlertController(title: "error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
