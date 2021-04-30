//
//  HomeView.swift
//  Transcribe
//
//  Created by Stone Chen on 4/28/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var notes = Notes()
    
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
                                Text(note.date)
                            }
                        }
                    })
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing: NavigationLink(destination: NoteCreationView()) {
                Image(systemName: "square.and.pencil")
            }
            )
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Fixes constraint warnings?
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
