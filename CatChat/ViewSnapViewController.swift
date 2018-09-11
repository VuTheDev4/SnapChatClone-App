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

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap : DataSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let snapDictionary = snap?.value as? NSDictionary {
            if let description = snapDictionary["description"] as? String {
                if let imageURL = snapDictionary["imageURL"] as? String {
                    messageLabel.text = description
                    
                    if let url = URL(string: imageURL) {
                        imageView.sd_setImage(with:url)
                    }
                    
                }
            }
        }
    }
    


}
