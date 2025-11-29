//
//  DataService.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//

//internal import CoreData
//
//class DataService {
//    private let context = CoreDataStack.shared.context
//    
//    func fetchNotes() -> [Note] {
//        let request: NSFetchRequest<Note> = Note.fetchRequest()
//        return (try? context.fetch(request)) ?? []
//    }
//    
//    func addNote(title: String){
//        let note = Note(context: context)
//        note.id = UUID()
//        note.title = title
//        note.createdAt = Date()
//        note.isPinned = false
//        try? context.save()
//    }
//    
//    func deleteNote(note: Note){
//        context.delete(note)
//        try? context.save()
//    }
//}
