//
//  TaskTableViewController.swift
//  NotesApp
//
//  Created by SEAN ULRIC BUGUINA CHUA stu on 16/11/21.
//

import UIKit


class TaskTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: currentDate)
    }
    
    @IBAction func addTaskPressed(_ sender: Any) {
        
        let addTaskAlert = UIAlertController(title: "New Task",
                                             message: "Please enter the task",
                                             preferredStyle: .alert)
        
        addTaskAlert.addTextField { textField in
            textField.placeholder = "Task Name"
            textField.keyboardType = .default
        }
        
        addTaskAlert.addAction(UIAlertAction(title: "Create",
                                             style: .default,
                                             handler: {
            (_) in
            if let alertTextField = addTaskAlert.textFields!.first!.text {
                let taskItem: Task = Task()
                taskItem.taskSubject = alertTextField
                taskItem.taskCreationDate = self.getCurrentDate()
                taskItem.taskModifiedDate = self.getCurrentDate()
                self.appDelegate.arrayOfOutstandingTasks.append(taskItem)
                self.tableView.reloadData()
            }
        }))
        self.present(addTaskAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
//        let taskItem: Task = Task()
//        taskItem.taskSubject = "Test"
//        taskItem.taskCreationDate = self.getCurrentDate()
//        taskItem.taskModifiedDate = self.getCurrentDate()
//        self.appDelegate.arrayOfOutstandingTasks.append(taskItem)
        tableView.register(TaskTableViewCell.nib(), forCellReuseIdentifier: "taskCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return appDelegate.arrayOfOutstandingTasks.count
        }
        return appDelegate.arrayOfCompletedTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        // Configure the cell...
        cell.configureItems(indexPath: indexPath)
        cell.delegate = self
        
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Outstanding Tasks"
        } else {
            return "Completed Tasks"
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if indexPath.section == 0 {
                appDelegate.arrayOfOutstandingTasks.remove(at: indexPath.row)
            } else {
                appDelegate.arrayOfCompletedTasks.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        var task: Task?
        if fromIndexPath.section == 0 {
            task = appDelegate.arrayOfOutstandingTasks.remove(at: fromIndexPath.row)
        } else {
            task = appDelegate.arrayOfCompletedTasks.remove(at: fromIndexPath.row)
        }
        
        if to.section == 0 {
            appDelegate.arrayOfOutstandingTasks.insert(task!, at: to.row)
        } else {
            appDelegate.arrayOfCompletedTasks.insert(task!, at: to.row)
        }
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TaskTableViewController: TaskTableViewCellDelegate {
    func checkBoxButtonPressed(indexPath: IndexPath) {
        if indexPath.section == 0 {
            let outstandingTask = appDelegate.arrayOfOutstandingTasks[indexPath.row]
            appDelegate.arrayOfOutstandingTasks.remove(at: indexPath.row)
            appDelegate.arrayOfCompletedTasks.append(outstandingTask)
            tableView.reloadData()
        } else {
            let completedTask = appDelegate.arrayOfCompletedTasks[indexPath.row]
            appDelegate.arrayOfCompletedTasks.remove(at: indexPath.row)
            appDelegate.arrayOfOutstandingTasks.append(completedTask)
            tableView.reloadData()
        }
    }

    
}
