//
//  TextBox.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import SwiftUI

/// Textbox
struct TextBox: View {
    @State var label: String?
    @Binding var value: String
    @State var placeholder: String
    
    @State private var dynamicHeight: CGFloat = 400
    @FocusState private var isFocused: Bool
    @State private var focusTracker: Bool = false
    
    init(label: String? = nil, value: Binding<String>, placeholder: String = "") {
        _label = State(initialValue: label)
        _value = value
        _placeholder = State(initialValue: placeholder)
    }
    
    /// View body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let label = label {
                Text(label).modifier(LabelStyle())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocused ? Color("pink_primary") : Color("black_primary"), lineWidth: 2)
                    .frame(minHeight: dynamicHeight + 20, maxHeight: dynamicHeight + 20)
                
                UITExtViewWrapper(text: $value, calculatedHeight: $dynamicHeight) {
                    print(value)
                }
                .padding(.horizontal, 20)
                .focused($isFocused)
                .onChange(of: isFocused) { focusTracker = $0 }
                .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
                .background(placeholderView, alignment: .topLeading)
            }
        }
    }
    
    /// Handle placeholder
    var placeholderView: some View {
        Group {
            if value.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
            }
        }
    }
}

/// UITextViewWrapper
private struct UITExtViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)? /// Handle on completion
    
    /// For makeUIView
    /// - Parameter context: context
    /// - Returns: text field with type UITextView
    func makeUIView(context: Context) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator
        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    /// To update UI view
    /// - Parameters:
    ///   - uiView: UITextView
    ///   - context: the context to update
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        UITExtViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    /// Recalulate height
    /// - Parameters:
    ///   - view: view of type UIView
    ///   - result: Binding of CFGloat
    private static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }
    
    /// Make coordinatoor
    /// - Returns: return Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }
    
    /// Class coordinator
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)? /// Handle on done
        
        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }
        
        /// Text view did change, take value and trigger recalculate height
        /// - Parameter textView: text view
        func textViewDidChange(_ textView: UITextView) {
            text.wrappedValue = textView.text
            UITExtViewWrapper.recalculateHeight(view: textView, result: calculatedHeight)
        }
        
        /// On done trigger completion and resign first responder
        /// - Parameters:
        ///   - textView: textview
        ///   - range: range
        ///   - text: text
        /// - Returns: boolean of true or false
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }
}
