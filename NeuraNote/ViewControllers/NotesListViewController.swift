//
//  NotesListViewController.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//
import UIKit

class NotesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = NotesListViewModel(manager: CoreDataStack())
    var selectedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        registerDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.manager.loadCoreData { [weak self] success in
            if success {
                self?.viewModel.fetchNotes()
                self?.tableView.reloadData()
            }
        }
    }
    
    func registerDelegates(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "NoteCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NoteCellTableViewCell")
        
        searchBar.delegate = self
    }
    @IBAction func createNewNote(_ sender: Any) {
        let newNote = viewModel.createNote()
        openNoteEditor(note: newNote)
    }
    
    @IBAction func createNewNoteTapped(_ sender: UIBarButtonItem) {
        let newNote = viewModel.createNote()
        openNoteEditor(note: newNote)
    }
    
    func openNoteEditor(note: Note) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditNoteViewController") as! EditNoteViewController
        vc.note = note
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellTableViewCell", for: indexPath) as? NoteCellTableViewCell else{
            fatalError()
        }
        let note = viewModel.notes[indexPath.row]
        
        cell.headingLabel?.text = note.title
        cell.detailLabel?.text = note.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = viewModel.notes[indexPath.row]
        openNoteEditor(note: note)
    }
    
    // Swipe-to-delete
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let note = viewModel.notes[indexPath.row]
            viewModel.delete(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension NotesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchNotes(query: searchText)
        tableView.reloadData()
    }
}
