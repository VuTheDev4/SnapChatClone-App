//
//  SnapsViewController.swift
//  CatChat
//
//  Created by Vu Duong on 9/7/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UITableViewController {
    
    var snaps : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUserid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(currentUserid).child("snaps").observe(.childAdded) { (snapshot) in
                self.snaps.append(snapshot)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
        print("Logout successful!")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        if let snapDictionary = snap.value as? NSDictionary {
            if let email = snapDictionary["from"] as? String {
                cell.textLabel?.text = email
            }
        }
        return  cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewSnapsSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapsSegue" {
            if let viewVC = segue.destination as? ViewSnapViewController {
                if let snap = sender as? DataSnapshot {
                    viewVC.snap = snap
                }
                
            }
        }
    }
}
