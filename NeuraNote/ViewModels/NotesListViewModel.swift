//
//  NotesListViewModel.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//

class NotesListViewModel {
    private let dataService = DataService()
    var notesUpdated: (() -> Void)?
    private(set) var notes: [Note] = []
    
    func fetchNotes() {
        notes = dataService.fetchNotes()
        notesUpdated?()
    }
    
    func addNote(title: String){
        dataService.addNote(title: title)
        fetchNotes()
    }
    func deleteNote(at index: Int){
        dataService.deleteNote(note: notes[index])
        fetchNotes()
    }
}
