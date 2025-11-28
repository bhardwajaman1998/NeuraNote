//
//  NotesListViewController.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//
import UIKit

class NotesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = NotesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModel.notesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.fetchNotes()
    }
    
    func setUptable(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let noteCellNib = UINib(nibName: "NoteCellTableViewCell", bundle: nil)
        tableView.register(noteCellNib, forCellReuseIdentifier: "NoteCellTableViewCell")
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        guard let noteController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController else{
            fatalError()
        }
        print(navigationController ?? nil)
        self.navigationController?.pushViewController(noteController, animated: true)
    }
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellTableViewCell", for: indexPath) as? NoteCellTableViewCell else {
            fatalError()
        }
        cell.headingLabel?.text = viewModel.notes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteNote(at: indexPath.row)
        }
    }
}
