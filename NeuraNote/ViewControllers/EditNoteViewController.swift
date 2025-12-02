//
//  EditNoteViewController.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-30.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
   
    var note: Note!
    var viewModel: NotesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let add = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = add
        setUpNote()
    }
    
    func setUpNote() {
        title = "Edit Note"
        
        contentTextView.text = (note.title ?? "") + "\n" + (note.content ?? "")
        
        contentTextView.delegate = self
        styleTextView()
    }
    
    @objc func menuButtonTapped() {
        let split = splitText(contentTextView.text ?? "")
        viewModel.update(note,
                         title: split.title,
                         content: split.content)
        navigationController?.popViewController(animated: true)
    }
    
    private func splitText(_ fullText: String) -> (title: String, content: String){
        let lines = fullText.components(separatedBy: .newlines)
        
        let title = lines.first ?? ""
        
        var content = lines.dropFirst().joined(separator: "\n")
        
        if content.isEmpty {
            content = ""
        }
        
        return (title, content)
    }
}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        styleTextView()
    }

    private func styleTextView() {
        let fullText = contentTextView.text ?? ""

        let attributed = NSMutableAttributedString(string: fullText)

        // Reset all text to body style
        attributed.addAttribute(.font,
                                value: UIFont.systemFont(ofSize: 17),
                                range: NSRange(location: 0, length: attributed.length))

        // Detect first line
        let lines = fullText.components(separatedBy: "\n")
        let firstLine = lines.first ?? ""

        let headingRange = (fullText as NSString).range(of: firstLine)

        // Apply big title font to first line
        if headingRange.location != NSNotFound {
            attributed.addAttribute(.font,
                                    value: UIFont.systemFont(ofSize: 26, weight: .bold),
                                    range: headingRange)
        }

        // Prevent jumps / maintain cursor correctly
        let selectedRange = contentTextView.selectedRange
        contentTextView.attributedText = attributed
        contentTextView.selectedRange = selectedRange
    }
}
