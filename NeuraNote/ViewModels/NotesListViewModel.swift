//
//  NotesListViewModel.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//

internal import CoreData

class NotesListViewModel {
    
    let manager: CoreDataStack
    var notes: [Note] = []
    
    init(manager: CoreDataStack) {
        self.manager = manager
    }
    
    func fetchNotes(query: String = "") {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        if !query.isEmpty {
            request.predicate = NSPredicate(format: "title CONTAINS[c] %@", query)
        }
        
        do {
            notes = try manager.persistentConatiner.viewContext.fetch(request)
        } catch {
            print("Failed fetching notes:", error)
        }
    }
    
    func createNote() -> Note {
        let note = Note(context: manager.persistentConatiner.viewContext)
        note.id = UUID()
        note.createdAt = Date()
        save()
        fetchNotes()
        return note
    }
    
    func delete(_ note: Note) {
        manager.persistentConatiner.viewContext.delete(note)
        save()
        fetchNotes()
    }
    
    func update(_ note: Note, title: String, content: String) {
        
        if title.isEmpty && content.isEmpty {
            delete(note)
        }else{
            note.title = title
            note.content = content
            save()
            fetchNotes()
        }
    }
    
    func save() {
        do {
            try manager.persistentConatiner.viewContext.save()
        } catch {
            print("Save error:", error)
        }
    }
}
