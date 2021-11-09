//
//  NotesTableTableViewController.swift
//  NotesApp
//
//  Created by SEAN ULRIC BUGUINA CHUA stu on 4/11/21.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //    private var _noteSubject: String = ""
    //    private var _noteContent: String = ""
    //    private var _noteCreationDate: String = ""
    //    private var _noteModifiedDate: String = ""
    
    
    let noteConfigurationAlert = UIAlertController(title: "New Note",
                                                   message: "Give your new note a subject",
                                                   preferredStyle: .alert)
    let newNoteAlert = UIAlertController(title: "New Note...",
                                         message: "Which type of Note would you like to create?",
                                         preferredStyle: .actionSheet)
    
    func configureAlertActions() {
        noteConfigurationAlert.addTextField { textField in
            textField.placeholder = "Subject"
            textField.keyboardType = .default
        }
        
        
        noteConfigurationAlert.addAction(UIAlertAction(title: "Create",
                                                       style: .default,
                                                       handler: {
            (_) in
            if let alertTextInput = self.noteConfigurationAlert.textFields!.first!.text {
                self.delegate.nD.noteSubject = alertTextInput
                self.performSegue(withIdentifier: "showNewNote", sender: self)
                print(self.delegate.nD.noteSubject)
            }
            
        }))
        
        newNoteAlert.addAction(UIAlertAction(title: "New Note",
                                             style: .default,
                                             handler: {
            (_) in
            self.present(self.noteConfigurationAlert, animated: true, completion: nil)
        }))
        
        
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        self.present(newNoteAlert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAlertActions()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return delegate.nD.notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewNote" {
            segue.destination as! NoteDetailViewController
            
        }
    }
    
    
}
