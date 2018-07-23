//
//  ViewController.swift
//  bucketList_5
//
//  Created by J on 7/15/2018.
//  Copyright © 2018 Jman. All rights reserved.
//
// *********** MAIN VC **********
import UIKit
import CoreData

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tableData: [Note] = []
    
    
    
    
    //====== ✈️✈️✈️ landing field for AddVC UNWIND (savePressed)
    @IBAction func unwindFromAddVC (segue: UIStoryboardSegue){
        print("inside unwindFromAddVC")
        let src = segue.source as! AddVC
        let title = src.addTitleTextField.text!
        let desc = src.addDescTextField.text!
        let date = src.addDatePicker.date
        print("data from unwindFromAddVC", title, desc, date)
        
        //now that we got data save to db and update table
        let addNew = Note(context: context)
        addNew.title = title
        addNew.desc = desc
        addNew.date = date
        appDelegate.saveContext()
        
        //now update table
        tableData.append(addNew)
        tableView.reloadData()
    }
    
    // ====== ✈️ ✈️ ✈️ landing field for EditVC UNWIND (savePressed)
    @IBAction func undwindFromEditVC (segue: UIStoryboardSegue) {
        print("inside unwindFromEditVC")
        let src = segue.source as! EditVC
        let title = src.editTitleTextField.text!
        let desc = src.editDescTextField.text!
        let date = src.editDatePicker.date
        print("data from unwindFromEditVC", title, desc, date)
        
        if let indexPath = src.indexPath {
        let editNote = tableData[indexPath.row]
            editNote.title = title
            editNote.desc = desc
            editNote.date = date
            appDelegate.saveContext()
            
            //update tableView NOT tableData
            tableView.reloadData()
        }
    }
    
    // ====== ✈️ ✈️ ladning UNWIND from SHOW VC (editDeletePressed) =======
    @IBAction func unwindFromShowVC (segue: UIStoryboardSegue) {
        print("inside unwindFromShowVC")
        let src = segue.source as! ShowVC
        if let indexPath = src.indexPath {
            let note = tableData[indexPath.row]
            if src.deleteBool == true {
//   context.delete(self.tableData[indexPath.row])
                // or
//                let note = tableData[indexPath.row]
                context.delete(note)
                
                tableData.remove(at: indexPath.row)
                appDelegate.saveContext()
//   tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }
            // check checkmark button
            if src.checkmarkStatus! {
////                let note = tableData[indexPath.row]
//                note.completed = true
//                appDelegate.saveContext()
//                tableView.reloadData()
                changeStatus(indexPath: indexPath)
            }

        }
    }
    
    // Fecth ALL Notes
    func fetchAll() {
        let request:NSFetchRequest<Note> = Note.fetchRequest()
        do {
            tableData = try context.fetch(request)
        } catch {
            print("couldn't fetchAll from DB", error)
        }
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        print("addPresses")
        performSegue(withIdentifier: "AddSegue", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        fetchAll()
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    // CHANGE CHECK MARK ---- ✅
    func changeStatus(indexPath: IndexPath) {
        let note = tableData[indexPath.row]
        if note.completed == true {
            note.completed = false
            appDelegate.saveContext()
            tableView.reloadData()
        } else {
            note.completed = true
            appDelegate.saveContext()
            tableView.reloadData()
        }
    }
    
    //button for toggling check / uncheck ✅ -- i dont like this fucntion >_<
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        print("checkButtonPressed")
        let buttonPossition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView) // this gets the indexpath
        let selectedIndex = self.tableView.indexPathForRow(at: buttonPossition)
        print("INDEX PATH", selectedIndex?.row)
        //also changes the checkmark
//        if let selected = selectedIndex {
//            changeStatus(indexPath: selected)
//        }
        let urgent_task = tableData[(selectedIndex?.row)!]
        if urgent_task.urgent == true {
            urgent_task.urgent = false
            appDelegate.saveContext()
            tableView.reloadData()
        } else {
            urgent_task.urgent = true
            appDelegate.saveContext()
            tableView.reloadData()
        }
        
        
    }
    
    
//======== PREPARE SEGUE ======== to send to other VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue EDIT
        if segue.identifier == "EditSegue" {
            print("going to editVC from prepare segue -> EditSegue")
            if let indexPath = sender as? IndexPath {
                // STEP 2: declare destination
                let dest = segue.destination as! EditVC
                // STEP 3: package data
                let note = tableData[indexPath.row]
                // STEP 4: go to editVC and add STEP 5
                dest.note = note
                dest.indexPath = indexPath
            }
            
        }
        //show segue
        else if segue.identifier == "showSegue" {
            print("going to ViewVC")
            if let indexPath = sender as? IndexPath {
                let dest = segue.destination as! ShowVC
                let note = tableData[indexPath.row]
                dest.note = note
                dest.indexPath = indexPath
            }
        }
    }
} // ------------- END ------------ VC--------

// ========= EXTENSIONS ==========
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACell", for: indexPath) as! ACellVC
        let note = tableData[indexPath.row]
        cell.titleCellLabel.text = note.title
        cell.descCellLabel.text = note.desc
        //date format
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        cell.dateCellLabel.text = formatter.string(from: note.date!)
        //is cell checked?
        if note.completed == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        if note.urgent == true {
            cell.urgentCellLabel.setImage(#imageLiteral(resourceName: "high_p"), for: .normal)
            cell.backgroundColor = .yellow
        } else {
            cell.urgentCellLabel.setImage(#imageLiteral(resourceName: "low_p"), for: .normal)
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    //DELETE
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") {
            (action, view, done) in
            
            self.context.delete(self.tableData[indexPath.row])
            self.tableData.remove(at: indexPath.row)
            self.appDelegate.saveContext()
            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
            done(true)
        }
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeConfig
    }
    
    // EDIT & CHECK
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //updateAction ----
        let updateAction = UIContextualAction(style: .normal, title: "edit") {
            (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in success(true)
            self.performSegue(withIdentifier: "EditSegue", sender: indexPath)
        }
        //checkmarkAction
        let checkmarkAction = UIContextualAction(style: .normal, title: "check") {
            (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in success(true)
            self.changeStatus(indexPath: indexPath)
        }
        updateAction.backgroundColor = .blue
        checkmarkAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [updateAction, checkmarkAction])
    }
    
    //SHOW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSegue", sender: indexPath)
    }
}



