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
        if theEvent.keyCode == 36  { // enter
            let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
            
            switch self.stringValue {
            case "me la fai dire una cosa ?":
                let s = NSSound(named: "melafadireunacosa.mp3")
                s?.play()
                
            case "c'è la madama dietro ?":
                let s = NSSound(named: "celamadamadietro.mp3")
                s?.play()
        
            case "siamo in pizzeria ?":
                let s = NSSound(named: "siamoinpizzeria.mp3")
                s?.play()
                
            default:
                appDelegate.speechSynth.startSpeakingString(self.stringValue)
            }
            
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
        self.window?.opaque = false
        self.window?.center()
        self.window?.makeKeyWindow()
        
        mtext.becomeFirstResponder()
        mtext.focusRingType = NSFocusRingType.None
        
    }
    
    override func cancelOperation(sender: AnyObject?) {
        self.window?.close()
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        appDelegate.lastFocusedApp.activateWithOptions(NSApplicationActivationOptions.ActivateIgnoringOtherApps)
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        NSLog("HERE")

        let tf: NSControl = obj.object as NSControl
        tf.complete(nil)
    }

}