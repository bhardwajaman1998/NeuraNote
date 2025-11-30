//
//  NotesListViewController.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//
import UIKit

class NotesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let manager = CoreDataStack()
    private var viewModel: NotesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NotesListViewModel(manager: self.manager)
        viewModel?.loadData()
    }
    
    func setUptable(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let noteCellNib = UINib(nibName: "NoteCellTableViewCell", bundle: nil)
        tableView.register(noteCellNib, forCellReuseIdentifier: "NoteCellTableViewCell")
        self.tableView.reloadData()
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        guard let noteController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController else{
            fatalError()
        }
        self.navigationController?.pushViewController(noteController, animated: true)
    }
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.notes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellTableViewCell", for: indexPath) as? NoteCellTableViewCell else {
            fatalError()
        }
        cell.headingLabel?.text = viewModel?.notes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let model = viewModel {
                model.deleteNote(model.notes[indexPath.row])
            }
        }
    }
}
