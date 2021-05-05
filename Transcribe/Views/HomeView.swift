//
//  HomeView.swift
//  Transcribe
//
//  Created by Stone Chen on 4/28/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @ObservedObject var notes = Notes()
    @State var text = ""
    @State var noteId = ""
    @State var remove = false
    
    var body: some View {
        NavigationView {
            VStack {
                if self.notes.data.isEmpty {
                    if self.notes.isEmpty {
                        // No notes
                        Text("No saved notes")
                    } else {
                        // Loading notes
                        LoadingIndicator()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack {
                            ForEach(self.notes.data) { note in
                                HStack {
                                    NavigationLink(destination: NoteCreationView(text: $text, noteId: $noteId)) {
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text(note.note)
                                                .lineLimit(1)
                                                .foregroundColor(.black)
                                            Divider()
                                        }
                                    }
                                    .simultaneousGesture(TapGesture().onEnded{
                                        self.text = note.note
                                        self.noteId = note.id
                                    })
                                    
                                    if self.remove {
                                        Button(action: {
                                            let db = Firestore.firestore()
                                            db.collection("notes").document(note.id).delete()
                                        }, label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        })
                                    }
                                }
                            }
                        }
                    })
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(
                leading: Button(action: {
                    self.remove.toggle()
                }, label: {
                    Image(systemName: self.remove ? "xmark.circle" : "trash")
                }), trailing: NavigationLink(destination: NoteCreationView(text: $text, noteId: $noteId)) {
                    Image(systemName: "square.and.pencil")
                }.simultaneousGesture(TapGesture().onEnded{
                    self.text = ""
                    self.noteId = ""
                }))
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Fixes constraint warnings?
    }
    
    func delete() {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
