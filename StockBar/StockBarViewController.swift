//
//  StockBarViewController.swift
//  StockBar
//
//  Created by Hiraku on 2016/12/26.
//  Copyright © 2016年 Hiraku. All rights reserved.
//

import Cocoa

class StockBarViewController: NSViewController {
    let barView = NSView()
    var itemCount: Int = 0
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidAppear() {
        let perfPath = String.init(format: "/Users/%@/Library/Containers/com.apple.ncplugin.stocks/Data/Library/Preferences/com.apple.stocks.plist", NSUserName())

        let systemPref = NSDictionary.init(contentsOfFile: perfPath)
        if (systemPref != nil) {
            
            var stocks = systemPref?["stocks"] as! [NSDictionary]
            itemCount = stocks.count
            
            barView.frame = CGRect(x: 0, y: 0, width: CGFloat(itemCount * 220 * 2), height: self.view.frame.height)
            barView.layer?.position = CGPoint(x: 0, y: 0)
            
            for x in 0...itemCount * 2 - 1 {
                var index = x
                if x >= itemCount {
                    index = x - itemCount
                }
                
                let name = stocks[index]["symbol"] as! String
                var price = stocks[index]["price"] as! String
                var changes = stocks[index]["change"] as! String
                let isRising: Bool = (changes as NSString).floatValue >= 0 ? true : false
                
                if price.characters.count > 7 {
                    price = (price as NSString).substring(to: 6)
                }
                
                if changes.characters.count > 6 {
                    if isRising == true {
                        changes = (changes as NSString).substring(to: 5)
                        changes = String.init(format: "+%@", changes)
                    }
                    else {
                        changes = (changes as NSString).substring(to: 6)
                    }
                }

                let stockItem = StockItemView.init(name: name, price: price, change: changes, rising: isRising)
                stockItem.frame = NSRect(x: 220 * x, y: 0, width: 210, height: 30)
                barView.addSubview(stockItem)
            }
            
            
            view.addSubview(barView)
            start()
        }
    }
    
    func start() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.repeatCount = .infinity
        animation.duration = Double(itemCount * 4)
        animation.fromValue = barView.layer?.position
        animation.toValue = NSValue(point: NSPoint(x: -CGFloat(itemCount * 220), y: 0))
        barView.layer?.add(animation, forKey: "position")
    }
}
