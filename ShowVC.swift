//
//  showVC.swift
//  bucketList_5
//
//  Created by J on 7/15/2018.
//  Copyright © 2018 Jman. All rights reserved.
//
// ========== SHOW VC ============
import UIKit

class ShowVC: UIViewController {
    
    var note: Note?
    var indexPath: IndexPath?
    var checkmarkStatus: Bool?
    var deleteBool: Bool = false
    
    @IBOutlet weak var showTitleTextLabel: UILabel!
    @IBOutlet weak var showDescTextLabel: UILabel!
    @IBOutlet weak var showDateTextLabel: UILabel!
    
    func unpack() {
        if let n = note {
            showTitleTextLabel.text = n.title
            showDescTextLabel.text = n.desc
            //date format
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            showDateTextLabel.text = formatter.string(from: n.date!)
            //checkmark
            self.checkmarkStatus = n.completed
        }
    }
    
    // CHECKMARK ✅
    @IBAction func checkPressed(_ sender: UIButton) {
        print("checkPressed")
        self.checkmarkStatus = true
        performSegue(withIdentifier: "unwindFromShowVC", sender: self)
    }
    
    // show DELETE
    @IBAction func showDeletePressed(_ sender: UIButton) {
        print("showDeletePressed")
        deleteBool = true
        performSegue(withIdentifier: "unwindFromShowVC", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        welcome()
        unpack()
        print(checkmarkStatus!)

    }
    
    
    
    
    
    
    func welcome() {
        let alert = UIAlertController(title: "welcome to Show VC!", message: "showing something", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss 👍", style: .default, handler: nil))
        self.present(alert, animated: true)
        unpack()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
