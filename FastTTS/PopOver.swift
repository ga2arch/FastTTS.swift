//
//  PopOver.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import Cocoa

class MWindow: NSWindow {
    
    func canBecomeKeyWindow() -> Bool {
        return true
    }
    
}

class MText: NSTextField {
    
    override func keyUp(theEvent: NSEvent) {
        if theEvent.keyCode == 36 { //enter
            let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
            appDelegate.speechSynth.startSpeakingString(self.stringValue)
            self.stringValue = ""
        }
        super.keyUp(theEvent)
    }
    
    
}

class PopOver: NSWindowController {
    
    @IBOutlet weak var mtext: MText!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.styleMask = NSBorderlessWindowMask
        self.window?.center()
        self.window?.makeKeyWindow()
        
        mtext.becomeFirstResponder()
        mtext.focusRingType = NSFocusRingType.None
    }
    
    override func cancelOperation(sender: AnyObject?) {
        self.window?.close()
    }
    
}