//
//  Notes.swift
//  Transcribe
//
//  Created by Stone Chen on 4/28/21.
//

import Foundation
import Firebase

struct Note: Identifiable {
    var id: String
    var note: String
    var date: String
}

class Notes: ObservableObject {
    @Published var data = [Note]()
    @Published var isEmpty = false
    
    init() {
        let db = Firestore.firestore()
        db.collection("notes").order(by: "date", descending: true).addSnapshotListener { (snapshot, err) in
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
                let id = documentChange.document.documentID
                let note = documentChange.document.get("notes") as! String
                let date = documentChange.document.get("date") as! Timestamp
                switch documentChange.type {
                case .added:
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
                    let dateString = dateFormatter.string(from: date.dateValue())
                    
                    self.data.append(Note(id: id, note: note, date: dateString))
                    
                case .modified:
                    for i in 0..<self.data.count {
                        if self.data[i].id == id {
                            self.data[i].note = note
                        }
                    }
                case .removed:
                    for i in 0..<self.data.count {
                        if self.data[i].id == id {
                            self.data.remove(at: i)
                            
                            if self.data.isEmpty {
                                self.data.isEmpty = true
                            }
                            return
                        }
                    }
                }
            }
        }
    }
}
