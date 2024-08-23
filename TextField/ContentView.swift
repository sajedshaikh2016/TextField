//
//  ContentView.swift
//  TextField
//
//  Created by Sajed Shaikh on 10/08/24.
//

import SwiftUI
import UIKit

// Custom UITextField to disable copy-paste
class NoCopyPasteTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Disable copy, paste, select, select all, and other options
        if action == #selector(copy(_:)) ||
           action == #selector(paste(_:)) ||
           action == #selector(cut(_:)) ||
           action == #selector(select(_:)) ||
           action == #selector(selectAll(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

// UIViewRepresentable to wrap the custom UITextField
struct NoCopyPasteTextFieldView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> NoCopyPasteTextField {
        let textField = NoCopyPasteTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: NoCopyPasteTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NoCopyPasteTextFieldView
        
        init(_ parent: NoCopyPasteTextFieldView) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text {
                parent.text = text
            }
        }
    }
}

// SwiftUI View using the custom TextField
struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        NoCopyPasteTextFieldView(text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(.secondary)
    }
}

#Preview {
    ContentView()
}
