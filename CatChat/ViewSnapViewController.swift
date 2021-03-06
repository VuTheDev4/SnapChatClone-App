//
//  ViewSnapViewController.swift
//  CatChat
//
//  Created by Vu Duong on 9/11/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap : DataSnapshot?
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapDictionary = snap?.value as? NSDictionary {
            if let description = snapDictionary["description"] as? String {
                if let imageURL = snapDictionary["imageURL"] as? String {
                    
                    messageLabel.text = description
                    
                    if let url = URL(string: imageURL) {
                        imageView.sd_setImage(with:url)
                    }
                    if let imageName = snapDictionary["imageName"] as? String {
                        self.imageName = imageName
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let currentUserid = Auth.auth().currentUser?.uid {
            
            if let key = snap?.key {
                Database.database().reference().child("users").child(currentUserid).child("snaps").child(key).removeValue()
                Storage.storage().reference().child("images").child(imageName).delete(completion: nil)            }
        }
        
        
    }
}
