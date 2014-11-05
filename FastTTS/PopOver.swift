//
//  PopOver.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import Cocoa

class MView: NSView {
    
    func canBecomeKeyWindow() -> Bool {
        return true
    }
    
}

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

    @IBOutlet weak var mtext: MText!
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
    }
    
}
