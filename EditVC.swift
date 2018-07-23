//
//  EditVC.swift
//  bucketList_5
//
//  Created by J on 7/15/2018.
//  Copyright © 2018 Jman. All rights reserved.
//
// ********* EDIT VC **********
import UIKit

class EditVC: UIViewController {

    // STEP 5: add these:
    var note: Note?
    var indexPath: IndexPath?
    
    @IBOutlet weak var editTitleTextField: UITextField!
    @IBOutlet weak var editDescTextField: UITextField!
    @IBOutlet weak var editDatePicker: UIDatePicker!
    
    // STEP 6: now that we received the data from the prepare SEGUE (mainVC) to editSegue -> EditVC set the labels with values sent from indexpath DB inside VIEW DID LOAD!!!!!!
    
    //if i have a note from the edit/add unwrap it
    //if i get a note take all the data out of the note and put it in the fields
    func unpack() {
        if let n = note {
            editTitleTextField.text = n.title
            editDescTextField.text = n.desc
            editDatePicker.date = n.date! //<-- force
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call unpack to store data
        unpack()
    }

    
    
    
    // SAVE EDIT
    @IBAction func saveEditPressed(_ sender: UIButton) {
        if editTitleTextField.text == "" || editDescTextField.text == "" {
            print("EMPTY STRINGS DO NOT GO BACK 😴")
            let alert = UIAlertController(title: "Field Error ☹️", message: "Fields must be filled in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss 👍", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if editDatePicker.date < Date() {
            print("must select future date")
            let alert = UIAlertController(title: "incorrect Date 📆", message: "date must be future ⏰", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss 👍", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "undwindFromEditVC", sender: self)
        }
    }


    // CANCEL DISMISS
    @IBAction func cancelEditPressed(_ sender: UIButton) {
        print("cancelEditPressed")
        dismiss(animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
