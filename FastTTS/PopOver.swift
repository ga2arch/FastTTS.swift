//
//  PopOver.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import AppKit
import Cocoa
import Carbon

class MWindow: NSWindow {
    
    func canBecomeKeyWindow() -> Bool {
        return true
    }
    
}

class MText: NSTextField {
    
    override func keyUp(theEvent: NSEvent) {
        if theEvent.keyCode == 36  { // enter
            speak()
        } else if theEvent.keyCode == 48 { // tab
            autocomplete()
        }
        super.keyUp(theEvent)
    }
    
    func speak() {
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        
        let path = NSHomeDirectory().stringByAppendingPathComponent(".fastTTS")
        let voicesPath = path.stringByAppendingPathComponent("voices/")
        let voicesPls = voicesPath.stringByAppendingPathComponent("voices.plist")
        
        let dict: [String:String] = NSDictionary(contentsOfFile: voicesPls)! as Dictionary
        
        if let filename = dict[self.stringValue] {
            let filepath = voicesPath.stringByAppendingPathComponent(filename)
            let s = NSSound(contentsOfFile: filepath, byReference: true)
            s?.play()
            
        } else {
            appDelegate.speechSynth.startSpeakingString(self.stringValue)
        }
        
        save()
        
        self.stringValue = ""
    }
    
    func autocomplete() {
        let path = NSHomeDirectory().stringByAppendingPathComponent(".fastTTS")
        let pls = path.stringByAppendingPathComponent("history.pls")
        
        let dict = NSDictionary(contentsOfFile: pls)!
        let keys: [String] = dict.keysSortedByValueUsingComparator {
            ($1 as NSNumber).compare($0 as NSNumber)
        } as [String]
        
        for k in keys {
            if k.hasPrefix(self.stringValue) {
                self.stringValue = k
            }
        }
    }
    
    func save() {
        let path = NSHomeDirectory().stringByAppendingPathComponent(".fastTTS")
        let pls = path.stringByAppendingPathComponent("history.pls")
        
        var dict: NSMutableDictionary = NSDictionary(contentsOfFile: pls)!.mutableCopy() as NSMutableDictionary
        let p = self.stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if let p = dict[p] as Int? {
            dict[p] = p+1
        } else {
            dict[p] = 1
        }
        
        dict.writeToFile(pls, atomically: true)
    }
}

class PopOver: NSWindowController {
    
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
    }
    
    override func cancelOperation(sender: AnyObject?) {
        self.window?.close()
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        appDelegate.lastFocusedApp.activateWithOptions(NSApplicationActivationOptions.ActivateIgnoringOtherApps)
    }
    
}