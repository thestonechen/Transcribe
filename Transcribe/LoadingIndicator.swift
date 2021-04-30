//
//  LoadingIndicator.swift
//  Transcribe
//
//  Created by Stone Chen on 4/29/21.
//

import SwiftUI

struct LoadingIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
