import Foundation
import SwiftUI
import AppKit

struct CustomTextField: NSViewRepresentable {
    @Binding var text: String
    let index: Int
    let focusedIndex: Int
    let onCommand: (_ key: String) -> Void
    let onFocus: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onCommand)
    }
    
    func makeNSView(context: Context) -> NSTextField {
        let textField = FocusableTextField()
        textField.isBordered = false
        textField.drawsBackground = false
        textField.onFocus = onFocus
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
        
        DispatchQueue.main.async {
            if index == focusedIndex && nsView.currentEditor() == nil {
                nsView.becomeFirstResponder()
            } else {
                nsView.resignFirstResponder()
            }
        }
    }
    
    class Coordinator: NSObject, NSTextFieldDelegate {
        let parent: CustomTextField
        let onCommmand: (_ key: String) -> Void
        
        init(_ textField: CustomTextField, _ onKeyDown: @escaping (_ key: String) -> Void) {
            self.parent = textField
            self.onCommmand = onKeyDown
        }
        
        func controlTextDidChange(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField else { return }
            self.parent.text = textField.stringValue
        }
        
        func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            
            if commandSelector == #selector(NSStandardKeyBindingResponding.moveDown(_:)) {
                onCommmand("moveDown")
                return true
            }
            if commandSelector == #selector(NSStandardKeyBindingResponding.moveUp(_:)) {
                onCommmand("moveUp")
                return true
            }
            if commandSelector == #selector(NSStandardKeyBindingResponding.insertNewline(_:)) {
                onCommmand("insertNewline")
                return true
            }
            return false
        }
    }
}

class FocusableTextField: NSTextField {
    var onFocus: () -> Void = { }
    
    override func becomeFirstResponder() -> Bool {
        onFocus()
        return super.becomeFirstResponder()
    }
}

