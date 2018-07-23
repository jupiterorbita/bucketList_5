//
//  AddVC.swift
//  bucketList_5
//
//  Created by J on 7/15/2018.
//  Copyright © 2018 Jman. All rights reserved.
//
// ********** ADD VC **********
import UIKit

class AddVC: UIViewController {

    @IBOutlet weak var addTitleTextField: UITextField!
    @IBOutlet weak var addDescTextField: UITextField!
    @IBOutlet weak var addDatePicker: UIDatePicker!
    
    // CANCEL PRESSED
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        print("cancelPressed")
        dismiss(animated: true, completion: nil)
    }
    
    // SAVE PRESSED
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        print("savePressed")
        // check save
        if addTitleTextField.text == "" || addDescTextField.text == "" {
                print("EMPTY STRINGS DO NOT GO BACK 😴")
            let alert = UIAlertController(title: "Field Error ☹️", message: "Fields must be filled in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss 👍", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if addDatePicker.date < Date() {
            print("must select future date")
            let alert = UIAlertController(title: "incorrect Date 📆", message: "date must be future ⏰", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss 👍", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "unwindFromAddVC", sender: self)
            }
        }    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
