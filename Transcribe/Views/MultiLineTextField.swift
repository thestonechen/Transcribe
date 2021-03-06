//
//  MultiLineTextField.swift
//  Transcribe
//
//  Created by Stone Chen on 5/1/21.
//

import SwiftUI

struct MultiLineTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UITextView()
        
        if self.text != "" {
            view.text = self.text
            view.textColor = .black
        } else {
            view.text = "Start typing here"
            view.textColor = .gray
        }
       
        view.isEditable = true
        view.font = .systemFont(ofSize: 18)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return MultiLineTextField.Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiLineTextField
        
        init(_ parent: MultiLineTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = ""
                textView.textColor = .black
            }
            
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}
