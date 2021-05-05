//
//  HomeView.swift
//  Transcribe
//
//  Created by Stone Chen on 4/28/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var notes = Notes()
    @State var text = ""
    @State var noteId = ""
    
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
                                NavigationLink(destination: NoteCreationView(text: $text, noteId: $noteId)) {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text(note.note)
                                            .lineLimit(1)
                                            .foregroundColor(.black)
                                        Divider()
                                    }
                                }
                                .onDrag({ /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item Provider@*/NSItemProvider()/*@END_MENU_TOKEN@*/ })
                                .simultaneousGesture(TapGesture().onEnded{
                                    self.text = note.note
                                    self.noteId = note.id
                                })
                            }
                        }
                    })
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing: NavigationLink(destination: NoteCreationView(text: $text, noteId: $noteId)) {
                Image(systemName: "square.and.pencil")
            }.simultaneousGesture(TapGesture().onEnded{
                self.text = ""
                self.noteId = ""
            })
            )
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
