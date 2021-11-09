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
    
    @IBOutlet weak var subjectTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    func viewingMode() {
        subjectTextView.isEditable = false
        contentTextView.isEditable = false
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
        
        
        print(delegate.nD.noteSubject)
        print(delegate.nD.noteContent)
    }
    
    func editingMode() {
        _subjectThingy += 1
        subjectTextView.isEditable = true
        contentTextView.isEditable = true
        subjectTextView.text = "\(delegate.nD.noteSubject)"
        if contentTextView.text == nil || contentTextView.text == "" {
            contentTextView.text = "Start Writing!"
            contentTextView.textColor = UIColor.systemPink
        } else {
            contentTextView.text = ""
        }
        contentTextView.text = "\(delegate.nD.noteContent)"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _subjectThingy = 0
        viewingMode()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
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
