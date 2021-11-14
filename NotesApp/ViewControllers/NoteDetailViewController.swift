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
    private var _isInEditingMode = false
    private var _isFromEditingModeToViewingMode = false
    private var _isFirstTimeViewing = false
    private var _noteSubjectInput = ""
    
    
    @IBOutlet weak var subjectTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var modifiedDateLabel: UILabel!
    
    @IBAction func newNoteBackButton(_ sender: Any) {
        if _isInEditingMode {
            let leaveButtonWithoutSavingAlert = UIAlertController(
                title: "Are you sure you want to leave?",
                message: "Changes will not be saved",
                preferredStyle: .alert)
            
            leaveButtonWithoutSavingAlert.addAction(UIAlertAction(
                title: "Continue",
                style: .destructive,
                handler: {
                    (_) in
                    self.performSegue(withIdentifier: "GoBack", sender: self)
                }))
            
            leaveButtonWithoutSavingAlert.addAction(UIAlertAction(title: "Cancel",
                                                                  style: .cancel,
                                                                  handler: {
                (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(leaveButtonWithoutSavingAlert, animated: true, completion: nil)
        }
        if !_isInEditingMode {
            self.addDataToArray()
            self.performSegue(withIdentifier: "GoBack", sender: self)
        }
        
    }
    
    
    func viewingMode() {
        subjectTextView.isEditable = false
        contentTextView.isEditable = false
        subjectTextView.textColor = UIColor.black
        contentTextView.textColor = UIColor.black
        
        if !isFromAddButton {
            delegate.nD.noteSubject = subjectTextView.text.replacingOccurrences(of: "Subject: ", with: "")
        }
        delegate.nD.noteContent = contentTextView.text
        
        
        
        if !isFromAddButton {
            let selectedArrayIndex = delegate.arrayOfNotes[indexNumber]
            
            if _isFirstTimeViewing {
                // Subject
                if selectedArrayIndex.noteSubject == "" {
                    subjectTextView.textColor = UIColor.lightGray
                    subjectTextView.text = "Create a Subject for your note!"
                }
                else {
                    subjectTextView.text = "Subject: \(selectedArrayIndex.noteSubject)"
                }
                // Content
                if selectedArrayIndex.noteContent == "" {
                    contentTextView.textColor = UIColor.lightGray
                    contentTextView.text = "Click the 'Edit' Button To Start Typing"
                }
                else {
                    contentTextView.text = "\(selectedArrayIndex.noteContent)"
                }
                createdDateLabel.text = "Created on: \(selectedArrayIndex.noteCreationDate)"
                modifiedDateLabel.text = "Modified on: \(selectedArrayIndex.noteModifiedDate)"
            } else {
                _noteSubjectInput = subjectTextView.text
                subjectTextView.text = "Subject: \(_noteSubjectInput)"
            }
            
            
        } else if isFromAddButton {
            if _isFirstTimeViewing {
                subjectTextView.text = "Subject: \(delegate.nD.noteSubject)"
                if delegate.nD.noteSubject == "" {
                    subjectTextView.textColor = UIColor.lightGray
                    subjectTextView.text = "Create a Subject for your note!"
                } else {
                    
                }
                contentTextView.textColor = UIColor.lightGray
                contentTextView.text = "Click the 'Edit' Button To Start Typing"
            } else {
                _noteSubjectInput = subjectTextView.text
                subjectTextView.text = "Subject: \(_noteSubjectInput)"
                createdDateLabel.text = getCurrentDate()
                modifiedDateLabel.text = getCurrentDate()
            }
            
        }
        
        _isFirstTimeViewing = false
    }
    
    func editingMode() {
        subjectTextView.isEditable = true
        contentTextView.isEditable = true
        subjectTextView.textColor = UIColor.black
        contentTextView.textColor = UIColor.black
        _noteSubjectInput = ""
        subjectTextView.text = subjectTextView.text.replacingOccurrences(of: "Subject: ",
                                                                         with: "")
        contentTextView.text = contentTextView.text.replacingOccurrences(
            of: "Click the 'Edit' Button To Start Typing",
            with: "")
        
//
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
        _isFirstTimeViewing = true
        viewingMode()
        _isFirstTimeViewing = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tabBarController?.tabBar.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if self.isEditing {
            editingMode()
            _isInEditingMode = true
        } else {
            viewingMode()
            _isInEditingMode = false
            _isFromEditingModeToViewingMode = true
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
