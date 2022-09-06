//
//  TextBox.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import SwiftUI

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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let label = label {
                Text(label).modifier(LabelStyle())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocused ? Color("pink_primary") : Color.gray.opacity(0.4), lineWidth: 2)
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

struct TextBox_Previews: PreviewProvider {
    @State private static var value = "A"
    static var previews: some View {
        TextBox(value: $value, placeholder: "Hello")
                    .previewLayout(.sizeThatFits)
    }
}

private struct UITExtViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?
    
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
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        UITExtViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    private static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        
        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text.wrappedValue = textView.text
            UITExtViewWrapper.recalculateHeight(view: textView, result: calculatedHeight)
        }
        
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
