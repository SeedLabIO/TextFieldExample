//
//  ViewController.swift
//  TextFieldExample
//
//  Created by LiangAlen on 7/15/16.
//  Copyright © 2016 seedlab. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!

    @IBOutlet var textView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        textView.delegate = self
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController: NSControlTextEditingDelegate {

    // https://developer.apple.com/library/mac/documentation/Cocoa/Reference/NSControlTextEditingDelegate_Protocol/#//apple_ref/occ/intfm/NSControlTextEditingDelegate/control:textView:doCommandBySelector:

    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        print("Selector method inside text field: \(commandSelector)")
        if commandSelector == #selector(insertNewline(_:)) {
            if let modifierFlags = NSApplication.sharedApplication().currentEvent?.modifierFlags
                where (modifierFlags.rawValue & NSEventModifierFlags.ShiftKeyMask.rawValue) != 0 {
                print("Shift-Enter detected.")
            } else {
                print("Enter detected.")
            }
            // https://developer.apple.com/library/prerelease/content/qa/qa1454/_index.html
            // If we want to insert new line instead of default action, which will complete editing.
            textView.insertNewlineIgnoringFieldEditor(self)

            return true
        }
        // * return true: Ignore system default behavior.
        // * return false: Let system to execute its default implementation for the selector.
        return false
    }
}

extension ViewController: NSTextFieldDelegate { }

extension ViewController: NSTextViewDelegate {

    // https://developer.apple.com/library/mac/documentation/Cocoa/Reference/NSTextViewDelegate_Protocol/index.html#//apple_ref/occ/intfm/NSTextViewDelegate/textView:doCommandBySelector:

    func textView(textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        print("Selector method inside text view: \(commandSelector)")
        if commandSelector == #selector(insertNewline(_:)) {
            if let modifierFlags = NSApplication.sharedApplication().currentEvent?.modifierFlags
                where (modifierFlags.rawValue & NSEventModifierFlags.ShiftKeyMask.rawValue) != 0 {
                print("Shift-Enter detected.")
            } else {
                print("Enter detected.")
            }
        }
        // * return true: Ignore system default behavior.
        // * return false: Let system to execute its default implementation for the selector.
        return false
    }
}