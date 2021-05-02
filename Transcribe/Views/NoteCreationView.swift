//
//  NoteCreationView.swift
//  Transcribe
//
//  Created by Stone Chen on 4/30/21.
//

import SwiftUI

struct NoteCreationView: View {
    
    @State var text = ""
    
    var body: some View {
        MultiLineTextField(text: self.$text)
            .padding()
            .navigationBarTitle("", displayMode: .inline)
    }
}

struct NoteCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreationView()
    }
}
