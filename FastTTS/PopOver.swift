//
//  PopOver.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import AppKit
import Cocoa

class MWindow: NSWindow {
    
    func canBecomeKeyWindow() -> Bool {
        return true
    }
    
}

class MText: NSTextField {
    
    override func keyUp(theEvent: NSEvent) {
        if theEvent.keyCode == 36  { // enter
            let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
            
            let path = NSHomeDirectory()
            let voices = path.stringByAppendingPathComponent(".voices/")
            let pls = voices.stringByAppendingPathComponent("voices.plist")
            
            let dict: [String:String] = NSDictionary(contentsOfFile: pls)! as Dictionary
            
            if let filename = dict[self.stringValue] {
                let filepath = voices.stringByAppendingPathComponent(filename)
                let s = NSSound(contentsOfFile: filepath, byReference: true)
                s?.play()
                
            } else {
                appDelegate.speechSynth.startSpeakingString(self.stringValue)
            }
            
            self.stringValue = ""
        }
        
        super.keyUp(theEvent)
    }
}

class PopOver: NSWindowController, NSTextFieldDelegate {
    
    @IBOutlet weak var mtext: MText!
    var doingAutocomplete: Bool = false

    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.styleMask = NSBorderlessWindowMask
        self.window?.opaque = false
        self.window?.center()
        self.window?.makeKeyWindow()
        
        mtext.becomeFirstResponder()
        mtext.focusRingType = NSFocusRingType.None
        
        mtext.delegate? = self
    }
    
    override func cancelOperation(sender: AnyObject?) {
        self.window?.close()
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        appDelegate.lastFocusedApp.activateWithOptions(NSApplicationActivationOptions.ActivateIgnoringOtherApps)
    }
    
    @IBAction override func controlTextDidChange(sender: NSNotification) {
//        
//        if !doingAutocomplete {
//            let tf: NSTextField = sender.object as NSTextField
//            tf.complete(nil)
//        }
    }
    
}