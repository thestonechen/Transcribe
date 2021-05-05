//
//  NoteCreationView.swift
//  Transcribe
//
//  Created by Stone Chen on 4/30/21.
//

import SwiftUI
import Firebase

struct NoteCreationView: View {
    
    @Binding var text: String
    @Binding var noteId: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        MultiLineTextField(text: self.$text)
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.saveNote(text: self.text)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
            .disabled(text.isEmpty)
            )
    }
    
    // Move this to separate class to handle DB stuff
    func saveNote(text: String) {
        let db = Firestore.firestore()
        
        if self.noteId != "" {
            db.collection("notes").document(self.noteId).updateData(["notes": self.text]) { (err) in
                guard err == nil else {
                    print(err!.localizedDescription)
                    return
                }
            }
        } else {
            db.collection("notes").document().setData(["notes": text, "date": Date()]) { (err) in
                guard err == nil else {
                    print(err!.localizedDescription)
                    return
                }
            }
        }
    }
}
