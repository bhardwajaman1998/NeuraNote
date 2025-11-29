//
//  NotesListViewModel.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//

internal import CoreData

class NotesListViewModel {
    private let manager: CoreDataStack
    
    var notesUpdated: (() -> Void)?
    private(set) var notes: [Note] = []
    private(set) var notesLoaded = false
    
    init(manager: CoreDataStack){
        self.manager = manager
        loadData()
    }
    
    func loadData(){
        manager.loadCoreData{ [weak self] result in
            DispatchQueue.main.async{
                self?.notesLoaded = result
                if result {
                    self?.fetchNotes()
                }
            }
        }
    }
    
    func fetchNotes(with searchText: String = "") {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        if !searchText.isEmpty {
            request.predicate = NSPredicate(format: "title CONTAINS %@", searchText)
        }
        
        do{
            notes = try manager.persistentConatiner.viewContext.fetch(request)
        } catch{
            print("Error fetching notes: \(error)")
        }
    }
    
    func addNote() -> Note{
        let newNote = Note(context: manager.persistentConatiner.viewContext)
        newNote.id = UUID()
        newNote.createdAt = Date()
        saveContext()
        
        fetchNotes()
        
        return newNote
    }
    
    func deleteNote(_ note: Note){
        manager.persistentConatiner.viewContext.delete(note)
        saveContext()
        fetchNotes()
    }
    
    func updateNote(_ note: Note, title: String, content: String){
        note.title = title
        note.description = content
        saveContext()
        fetchNotes()
    }
    
    func searchNotes(with text: String) {
        fetchNotes(with: text)
    }
    
    private func saveContext(){
        do {
            try manager.persistentConatiner.viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
