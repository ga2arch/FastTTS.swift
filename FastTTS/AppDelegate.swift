//
//  AppDelegate.swift
//  FastTTS
//
//  Created by Gabriele Carrettoni on 05/11/14.
//  Copyright (c) 2014 Gabriele Carrettoni. All rights reserved.
//

import AppKit
import Cocoa
import Carbon

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var popover: NSWindowController = PopOver(windowNibName: "PopOver")

    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem : NSMenuItem = NSMenuItem()
    
    let speechSynth = NSSpeechSynthesizer(voice: NSSpeechSynthesizer.defaultVoice())

    override func awakeFromNib() {
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.title = "FastTTS"
        statusBarItem.target = self
        statusBarItem.action = Selector("openWindow:")
        
        //Add menuItem to menu
        menuItem.title = "Clicked"
        menuItem.action = Selector("setWindowVisible:")
        menuItem.keyEquivalent = ""
        menu.addItem(menuItem)
        
        var center = DDHotKeyCenter.sharedHotKeyCenter()
        let r = center.registerHotKeyWithKeyCode(49,
            modifierFlags: NSEventModifierFlags.CommandKeyMask.rawValue,
            target: self,
            action: Selector("openWindow:"),
            object: nil)
    }
    
    @IBAction func openWindow(sender: AnyObject) {
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
        popover.showWindow(nil)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

