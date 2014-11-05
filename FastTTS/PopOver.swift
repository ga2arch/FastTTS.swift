//
//  PopOver.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import Cocoa

class MText: NSTextField {
    
    override func keyUp(theEvent: NSEvent) {
        if theEvent.keyCode == 36 { //enter
            let speechSynth = NSSpeechSynthesizer(voice: NSSpeechSynthesizer.defaultVoice())
            speechSynth.startSpeakingString(self.stringValue)
        }
        super.keyUp(theEvent)
    }
    
}

class PopOver: NSWindowController {

    @IBOutlet var mwin: MWindow!
    @IBOutlet weak var mtext: MText!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.styleMask = NSBorderlessWindowMask
        self.window?.center()
        self.window?.makeKeyWindow()
    }
    
}
