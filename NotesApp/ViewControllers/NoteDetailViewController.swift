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
            self.addDataToArray()
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
        if isFromAddButton == false {
            delegate.nD.noteSubject = subjectTextView.text.replacingOccurrences(of: "Subject: ", with: "")
        }
        delegate.nD.noteContent = contentTextView.text
        subjectTextView.text = delegate.nD.noteSubject
        
        if !isFromAddButton {
            let selectedArrayIndex = delegate.arrayOfNotes[indexNumber]
            if selectedArrayIndex.noteSubject == "" {
                subjectTextView.text = "Click the 'Edit' Button To Start Typing"
            } else {
                subjectTextView.text = "Subject: \(selectedArrayIndex.noteSubject)"
            }
            
            if selectedArrayIndex.noteContent == "" {
                contentTextView.text = "Nothing Here"
            } else {
                contentTextView.text = "\(selectedArrayIndex.noteContent)"
            }
            
            createdDateLabel.text = selectedArrayIndex.noteCreationDate
            modifiedDateLabel.text = selectedArrayIndex.noteModifiedDate
            
        } else if isFromAddButton {
            if delegate.nD.noteSubject == "" {
                subjectTextView.text = "Click the 'Edit' Button To Start Typing"
            } else {
                subjectTextView.text = "Subject: \(delegate.nD.noteSubject)"
            }
            
            if delegate.nD.noteContent == "" {
                contentTextView.text = "Nothing Here Yet"
            } else {
                contentTextView.text = "\(delegate.nD.noteContent)"
            }
            
            createdDateLabel.text = getCurrentDate()
            modifiedDateLabel.text = getCurrentDate()
            
        }

        
    }
    
    func editingMode() {
        subjectTextView.isEditable = true
        contentTextView.isEditable = true
        if !isFromAddButton {
            let selectedArrayIndex = delegate.arrayOfNotes[indexNumber]
            if selectedArrayIndex.noteSubject == "" {
                subjectTextView.text = ""
            } else {
                subjectTextView.text = selectedArrayIndex.noteSubject
            }
            
            if selectedArrayIndex.noteContent == "" {
                contentTextView.text = ""
            } else {
                contentTextView.text = "\(selectedArrayIndex.noteContent)"
            }
            
            createdDateLabel.text = selectedArrayIndex.noteCreationDate
            modifiedDateLabel.text = selectedArrayIndex.noteModifiedDate
            
        } else if isFromAddButton {
            if delegate.nD.noteSubject == "" {
                subjectTextView.text = ""
            } else {
                subjectTextView.text = delegate.nD.noteSubject
            }
            
            if delegate.nD.noteContent == "" {
                contentTextView.text = ""
            } else {
                contentTextView.text = "\(delegate.nD.noteContent)"
            }
            
            createdDateLabel.text = getCurrentDate()
            modifiedDateLabel.text = getCurrentDate()
            
        }
    }
    
    func addDataToArray() {
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
    
 
    
    func getCurrentDate() -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            return formatter.string(from: currentDate)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewingMode()
        
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
