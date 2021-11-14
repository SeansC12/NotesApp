//
//  NoteDetailViewController.swift
//  NotesApp
//
//  Created by SEAN ULRIC BUGUINA CHUA stu on 9/11/21.
//

import UIKit
import Foundation

class NoteDetailViewController: UIViewController {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    private var _subjectThingy: Int = 0
    var indexNumber: Int = 0
    var isFromAddButton: Bool = true
    
    
    @IBOutlet weak var subjectTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var modifiedDateLabel: UILabel!
    
    @IBAction func newNoteBackButton(_ sender: Any) {
        let leaveButtonAlert = UIAlertController(title: "Are you sure you want to leave?",
                                                 message: nil,
                                                 preferredStyle: .alert)
        leaveButtonAlert.addAction(UIAlertAction(title: "Continue",
                                                 style: .destructive,
                                                 handler: {
            (_) in
            self.addDataToDictionary()
            self.performSegue(withIdentifier: "GoBack", sender: self)
        }))
        leaveButtonAlert.addAction(UIAlertAction(title: "Cancel",
                                                 style: .cancel,
                                                 handler: {
            (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(leaveButtonAlert, animated: true, completion: nil)
    }
    
    
    func viewingMode() {
        subjectTextView.isEditable = false
        contentTextView.isEditable = false
        subjectTextView.textColor = UIColor.black
        contentTextView.textColor = UIColor.black
        if _subjectThingy >= 1 {
            delegate.nD.noteSubject = subjectTextView.text.replacingOccurrences(of: "Subject: ", with: "")
        }
        delegate.nD.noteContent = contentTextView.text
        
        if subjectTextView.text == "" && delegate.nD.noteSubject == "" {
            subjectTextView.text = "Subject: Nothing Here"
        } else {
            subjectTextView.text = "Subject: \(delegate.nD.noteSubject)"
        }
       
        if contentTextView.text == "" && delegate.nD.noteContent == "" {
            contentTextView.text = "Nothing Here"
        } else {
            contentTextView.text = "\(delegate.nD.noteContent)"
        }
        
    }
    
    func addDataToDictionary() {
        if !isFromAddButton {
            let noteTypeFromArray = delegate.arrayOfNotes[indexNumber]
            noteTypeFromArray.noteSubject = subjectTextView.text.replacingOccurrences(of: "Subject: ", with: "")
            noteTypeFromArray.noteContent = contentTextView.text
            noteTypeFromArray.noteModifiedDate = getCurrentDate()
        } else {
            let noteItem: Note = Note()
            noteItem.noteSubject = subjectTextView.text.replacingOccurrences(of: "Subject: ", with: "")
            noteItem.noteContent = contentTextView.text
            noteItem.noteCreationDate = getCurrentDate()
            noteItem.noteModifiedDate = getCurrentDate()
            delegate.arrayOfNotes.append(noteItem)
        }
        

    }
    
    func editingMode() {
        _subjectThingy += 1
        subjectTextView.isEditable = true
        contentTextView.isEditable = true
        contentTextView.text = "\(delegate.nD.noteContent)"
        subjectTextView.text = "\(delegate.nD.noteSubject)"
    }
    
    func getCurrentDate() -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            return formatter.string(from: currentDate)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _subjectThingy = 0
        viewingMode()
        
        if !isFromAddButton {
            let selectedIndexOfArray = delegate.arrayOfNotes[indexNumber]
            subjectTextView.text = selectedIndexOfArray.noteSubject
            contentTextView.text = selectedIndexOfArray.noteContent
            createdDateLabel.text = selectedIndexOfArray.noteCreationDate
            modifiedDateLabel.text = selectedIndexOfArray.noteModifiedDate
            
        } else {
            subjectTextView.text = "Subject: \(delegate.nD.noteSubject)"
            contentTextView.text = delegate.nD.noteContent
            createdDateLabel.text = delegate.nD.noteCreationDate
            modifiedDateLabel.text = delegate.nD.noteModifiedDate
        }
        
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tabBarController?.tabBar.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if self.isEditing {
            editingMode()
        } else {
            viewingMode()
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
