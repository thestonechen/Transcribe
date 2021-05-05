//
//  NoteCreationView.swift
//  Transcribe
//
//  Created by Stone Chen on 4/30/21.
//

import SwiftUI
import Firebase

struct NoteCreationView: View {
    
    @State var text = ""
    
    var body: some View {
        MultiLineTextField(text: self.$text)
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.saveNote(text: self.text)
                print("Save button pressed...")
            }) {
                Text("Save")
            }
            .disabled(text.isEmpty)
            )
    }
    
    // Move this to separate class to handle DB stuff
    func saveNote(text: String) {
        let db = Firestore.firestore()
        db.collection("notes").document().setData(["notes": text, "date": Date()]) { (err) in
            guard err == nil else {
                print(err!.localizedDescription)
                return
            }
            
            
        }
    }
}

struct NoteCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreationView()
    }
}
