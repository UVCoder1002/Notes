//
//  NoteUpdateViewController.swift
//  Notes-App
//
//  Created by Urvashi Gupta on 04/01/24.
//

import UIKit

class NoteUpdateViewController: UIViewController {

    var note : Note?
    var update = false
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false{
//            self.deleteBtn.isEnabled = false
            self.deleteBtn.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if update == true {
            titleTextField.text = note?.title
            noteTextField.text = note?.note
        }
        else{
            titleTextField.text = ""
            noteTextField.text = ""
        }
       
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        if titleTextField.text != "" {
            if update == true{
                NetworkService.functions.updateNote(date: date, title: titleTextField.text ?? "", note: noteTextField.text, id: note!._id)
                self.navigationController?.popViewController(animated: true)
                
            }
            else{
                NetworkService.functions.addNote(date: date, title: titleTextField.text ?? "", note: noteTextField.text)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        NetworkService.functions.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)
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
