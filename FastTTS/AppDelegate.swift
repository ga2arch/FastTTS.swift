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
    
    var lastFocusedApp: NSRunningApplication!

    let center = DDHotKeyCenter.sharedHotKeyCenter()
    let speechSynth = NSSpeechSynthesizer(voice: NSSpeechSynthesizer.defaultVoice())

    override func awakeFromNib() {
        statusBarItem = statusBar.statusItemWithLength(-1)
//        statusBarItem.title = "FastTTS"
        statusBarItem.image = NSImage(named: "lips")
        statusBarItem.target = self
        statusBarItem.menu = menu
//        statusBarItem.action = Selector("openWindow:")
        
        //Add menuItem to menu
        menuItem.title = "Quit"
        menuItem.action = Selector("quit:")
        menuItem.keyEquivalent = ""
        menu.addItem(menuItem)
    }
    
    @IBAction func openWindow(sender: AnyObject) {
        lastFocusedApp = NSWorkspace.sharedWorkspace().frontmostApplication
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
        popover.showWindow(nil)
    }
    
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        center.registerHotKeyWithKeyCode(49,
            modifierFlags: NSEventModifierFlags.CommandKeyMask.rawValue,
            target: self,
            action: Selector("openWindow:"),
            object: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        center.unregisterHotKeyWithKeyCode(49,
            modifierFlags: NSEventModifierFlags.CommandKeyMask.rawValue)
    }
}

