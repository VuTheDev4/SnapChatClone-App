//
//  ViewSnapViewController.swift
//  CatChat
//
//  Created by Vu Duong on 9/9/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLbl: UILabel!
    
    var snap : DataSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapDictionary = snap?.value as? NSDictionary {
            if let description = snapDictionary["description"] as? String {
                if let imageUrl = snapDictionary["imageURL"] as? String {
                    messageLbl.text = description
                    
                    if let url = URL(string: imageUrl) {
                        imageView.sd_setImage(with: url)
                    }
                }
            }
        }
    }
}
