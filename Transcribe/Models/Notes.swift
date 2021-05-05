//
//  Notes.swift
//  Transcribe
//
//  Created by Stone Chen on 4/28/21.
//

import Foundation
import Firebase

struct Note: Identifiable {
    var id = UUID()
    var note: String
    var date: String
}

class Notes: ObservableObject {
    @Published var data = [Note]()
    @Published var isEmpty = false
    
    init() {
        let db = Firestore.firestore()
        db.collection("notes").addSnapshotListener { (snapshot, err) in
            guard let snapshot = snapshot, err == nil else {
                print(err!.localizedDescription)
                self.isEmpty = true
                return
            }
            
            if snapshot.documentChanges.isEmpty {
                self.isEmpty = true
                return
            }
            
            for documentChange in snapshot.documentChanges {
                switch documentChange.type {
                case .added:
                    
                    let note = documentChange.document.get("notes") as! String
                    
                    let date = documentChange.document.get("date") as! Timestamp
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
                    let dateString = dateFormatter.string(from: date.dateValue())
                    
                    self.data.append(Note(note: note, date: dateString))
                    
                case .modified:
                    return
                case .removed:
                    return
                }
            }
        }
    }
}
