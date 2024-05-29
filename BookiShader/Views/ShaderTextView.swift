/*
 ShaderTextView.swift
 Book of Shaders

 Created by Warren Moore on 6/15/23.
*/

/*
import Combine
import SwiftUI

class ShaderTextView: NSTextView {
    func setup(_ initialText: NSAttributedString) {
        attributedString = initialText
        allowsImageEditing = false
        allowsUndo = true
        backgroundColor = .clear
        layoutManager?.defaultAttachmentScaling = .scaleProportionallyDown
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    var attributedString: NSAttributedString {
        get { attributedString() }
        set { textStorage?.setAttributedString(newValue) }
    }

    var isFirstResponder: Bool {
        window?.firstResponder == self
    }
}

class ShaderTextEditorContext: ObservableObject {
    @Published var attributedString: NSAttributedString?
}

// MARK: - ShaderTextViewDelegate

class ShaderTextViewDelegate: NSObject, NSTextViewDelegate {
    public init(
        text: Binding<NSAttributedString>,
        textView: ShaderTextView,
        context: ShaderTextEditorContext
    ) {
        textView.attributedString = text.wrappedValue
        self.text = text
        self.textView = textView
        self.context = context
        super.init()
        self.textView.delegate = self
        subscribeToContextChanges()
    }

    public let context: ShaderTextEditorContext

    public var text: Binding<NSAttributedString>

    var textView: ShaderTextView

    public var cancellables = Set<AnyCancellable>()

    func subscribeToContextChanges() {
        context.$attributedString.sink(receiveCompletion: { _ in },
                                       receiveValue: { [weak self] in
            let selection = self?.textView.selectedRange()
            self?.setAttributedString(to: $0)
            if let selection {
                self?.textView.selectedRange = selection
            }
        }).store(in: &cancellables)
    }

    func syncContextWithTextView() {
        // This is admittedly janky, but it cuts down on flicker
        DispatchQueue.main.async {
            self.syncContextWithTextViewImmediate()
        }
    }

    func syncContextWithTextViewImmediate() {
        context.attributedString = self.textView.attributedString
    }

    func setAttributedString(to newValue: NSAttributedString?) {
        guard let newValue else { return }
        textView.attributedString = newValue
        text.wrappedValue = newValue
    }

    func textDidChange(_ notification: Notification) {
        syncContextWithTextView()
    }
}

// MARK: - ShaderTextEditor

struct ShaderTextEditor : NSViewRepresentable {
    typealias ViewUserConfiguration = (NSTextView) -> Void

    public let scrollView = ShaderTextView.scrollableTextView()

    public var textView: ShaderTextView {
        scrollView.documentView as? ShaderTextView ?? ShaderTextView()
    }

    private var text: Binding<NSAttributedString>

    @ObservedObject
    private var context: ShaderTextEditorContext

    private var userConfiguration: ViewUserConfiguration

    public init(
        text: Binding<NSAttributedString>,
        context: ShaderTextEditorContext,
        userConfiguration: @escaping ViewUserConfiguration = { _ in }
    ) {
        self.text = text
        self._context = ObservedObject(wrappedValue: context)
        self.userConfiguration = userConfiguration
    }

    func makeNSView(context: Context) -> some NSView {
        textView.setup(text.wrappedValue)
        userConfiguration(textView)
        return scrollView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
    }

    func makeCoordinator() -> ShaderTextViewDelegate {
        return ShaderTextViewDelegate(text: text,
                                      textView: textView,
                                      context: context)
    }
}
*/



/*
 /*
  ShaderTextView.swift
  Book of Shaders

  Created by Warren Moore on 6/15/23.
 */

 import Combine
 import SwiftUI

 #if os(macOS)
     typealias TextView = NSTextView
 #else
     typealias TextView = UITextView
 #endif

 #if os(macOS)
 class ShaderTextView: NSTextView {
     func setup(_ initialText: NSAttributedString) {
         attributedString = initialText
         allowsImageEditing = false
         allowsUndo = true
         backgroundColor = .clear
         layoutManager?.defaultAttachmentScaling = .scaleProportionallyDown
         setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
     }

     var attributedString: NSAttributedString {
         get { attributedString() }
         set { textStorage?.setAttributedString(newValue) }
     }

     var isFirstResponder: Bool {
         window?.firstResponder == self
     }
 }
 #else
 class ShaderTextView: UITextView {
     func setup(_ initialText: NSAttributedString) {
         attributedText = initialText
         isEditable = false
 //        isUndoEnabled = true
         backgroundColor = .clear
         textContainer.lineFragmentPadding = 0
         setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
     }

     override var attributedText: NSAttributedString! {
         didSet {
             textStorage.setAttributedString(attributedText)
         }
     }

     override var isFirstResponder: Bool {
         self.isFirstResponder
     }
 }
 #endif

 class ShaderTextEditorContext: ObservableObject {
     @Published var attributedString: NSAttributedString?
 }

 // MARK: - ShaderTextViewDelegate

 #if os(macOS)
     typealias TextViewDelegate = NSTextViewDelegate
 #else
     typealias TextViewDelegate = UITextViewDelegate
 #endif

 class ShaderTextViewDelegate: NSObject, TextViewDelegate {
     public init(
         text: Binding<NSAttributedString>,
         textView: ShaderTextView,
         context: ShaderTextEditorContext
     ) {
         #if os(macOS)
             textView.attributedString = text.wrappedValue
         #else
             textView.attributedText = text.wrappedValue
         #endif
         
         self.text = text
         self.textView = textView
         self.context = context
         super.init()
         self.textView.delegate = self
         subscribeToContextChanges()
     }

     public let context: ShaderTextEditorContext

     public var text: Binding<NSAttributedString>

     var textView: ShaderTextView

     public var cancellables = Set<AnyCancellable>()

     func subscribeToContextChanges() {
         context.$attributedString.sink(receiveCompletion: { _ in },
                                        receiveValue: { [weak self] in
             #if os(macOS)
                 let selection = self?.textView.selectedRange()
             #else
                 let selection = self?.textView.selectedRange
             #endif
             
             self?.setAttributedString(to: $0)
             if let selection {
                 self?.textView.selectedRange = selection
             }
         }).store(in: &cancellables)
     }

     func syncContextWithTextView() {
         // This is admittedly janky, but it cuts down on flicker
         DispatchQueue.main.async {
             self.syncContextWithTextViewImmediate()
         }
     }

     func syncContextWithTextViewImmediate() {
         #if os(macOS)
             context.attributedString = self.textView.attributedString
         #else
             context.attributedString = self.textView.attributedText
         #endif
     }

     func setAttributedString(to newValue: NSAttributedString?) {
         guard let newValue else { return }
         #if os(macOS)
             textView.attributedString = newValue
         #else
             textView.attributedText = newValue
         #endif
         
         text.wrappedValue = newValue
     }

     func textDidChange(_ notification: Notification) {
         syncContextWithTextView()
     }
 }

 // MARK: - ShaderTextEditor

 #if os(macOS)
     typealias ViewRepresentable = NSViewRepresentable
 #else
     typealias ViewRepresentable = UIViewRepresentable
 #endif

 struct ShaderTextEditor: ViewRepresentable {
     typealias ViewUserConfiguration = (TextView) -> Void

     #if os(macOS)
         public let scrollView = ShaderTextView.scrollableTextView()
     #else
         public let scrollView = ShaderTextView()
     #endif

     public var textView: ShaderTextView {
         scrollView.documentView as? ShaderTextView ?? ShaderTextView()
     }

     private var text: Binding<NSAttributedString>

     @ObservedObject
     private var context: ShaderTextEditorContext

     private var userConfiguration: ViewUserConfiguration

     public init(
         text: Binding<NSAttributedString>,
         context: ShaderTextEditorContext,
         userConfiguration: @escaping ViewUserConfiguration = { _ in }
     ) {
         self.text = text
         self._context = ObservedObject(wrappedValue: context)
         self.userConfiguration = userConfiguration
     }

     #if os(macOS)
         func makeNSView(context: Context) -> some NSView {
             textView.setup(text.wrappedValue)
             userConfiguration(textView)
             return scrollView
         }

         func updateNSView(_ nsView: NSViewType, context: Context) {
         }

         func makeCoordinator() -> ShaderTextViewDelegate {
             return ShaderTextViewDelegate(text: text,
                                           textView: textView,
                                           context: context)
         }
     #else
         func makeUIView(context: Context) -> some UIView {
             textView.setup(text.wrappedValue)
             userConfiguration(textView)
             return scrollView
         }

         func updateUIView(_ nsView: UIViewType, context: Context) {
         }

         func makeCoordinator() -> ShaderTextViewDelegate {
             return ShaderTextViewDelegate(text: text,
                                           textView: textView,
                                           context: context)
         }
     #endif
 }


 */
