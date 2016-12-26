//
//  AppDelegate.swift
//  StockBar
//
//  Created by Hiraku on 2016/12/26.
//  Copyright © 2016年 Hiraku. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTouchBarProvider, NSTouchBarDelegate {

    @IBOutlet weak var window: NSWindow!
    var touchBar: NSTouchBar?
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        touchBar = NSTouchBar()
        touchBar?.delegate = self
        touchBar?.defaultItemIdentifiers = [NSTouchBarItemIdentifier("tw.hiraku.stockbar.item")]
        
        setupStatusItem()
        NSApp.setActivationPolicy(.accessory) //Hide Dock
        show()
//        window.orderOut(window) //Hide Window
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        let item = NSCustomTouchBarItem(identifier: identifier)
        item.viewController = StockBarViewController()
        return item
    }
    
    func setupStatusItem() {
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        statusItem?.image = Bundle.main.image(forResource: "icon")
        statusItem?.isEnabled = true
        statusItem?.toolTip = "StockBar"
        statusItem?.highlightMode = true
        let statusMenu = NSMenu()
        statusMenu.addItem(withTitle: "Show", action: #selector(show), keyEquivalent: "")
        statusMenu.addItem(NSMenuItem.separator())
        statusMenu.addItem(withTitle: "Quit StockBar", action: #selector(terminate), keyEquivalent: "")
        statusItem?.menu = statusMenu
    }
    
    func show() {
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func terminate () {
        NSApp.terminate(nil)
    }
}

