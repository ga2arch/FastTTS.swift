//
//  AppDelegate.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let speechSynth = NSSpeechSynthesizer(voice: NSSpeechSynthesizer.defaultVoice())

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

