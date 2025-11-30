//
//  EditNoteViewController.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-30.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: Note!
    var viewModel: NotesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let add = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = add
        
        title = "Edit Note"
        
        titleField.text = note.title
        contentTextView.text = note.content
    }
    
    @objc func menuButtonTapped() {
        viewModel.update(note,
                         title: titleField.text ?? "",
                         content: contentTextView.text ?? "")
        navigationController?.popViewController(animated: true)
    }
}
