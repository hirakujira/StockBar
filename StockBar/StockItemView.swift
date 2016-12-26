//
//  StockItemView.swift
//  StockBar
//
//  Created by Hiraku on 2016/12/26.
//  Copyright © 2016年 Hiraku. All rights reserved.
//

import Cocoa


class VerticalNSTextFieldCell: NSTextFieldCell {
    
    override init(textCell string: String) {
        super.init(textCell: string)
        font = NSFont.systemFont(ofSize: 14)
        textColor = .white
        isEditable = false
        isBezeled = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRect(forBounds rect: NSRect) -> NSRect {
        let stringHeight: CGFloat = self.attributedStringValue.size().height
        var titleRect: NSRect = super.titleRect(forBounds: rect)
        titleRect.origin.y = rect.origin.y + (rect.size.height - stringHeight) / 2.0
        return titleRect
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: self.titleRect(forBounds: cellFrame), in: controlView)
    }
}

class StockItemView: NSView {

    let stockNameView = NSTextField()
    let stockPriceView = NSTextField()
    let stockDeltaBackgroundView = NSView()
    let stockDeltaView = NSTextField()
    var stockName = String()
    var stockPrice = String()
    var stockChange = String()
    var deltaValues = [Any]()
    var isRising = true
    
    init(name stockName: String, price stockPrice: String, change stockChange: String, rising isRising: Bool) {
        super.init(frame: NSRect.zero)
        self.stockName = stockName
        self.stockPrice = stockPrice
        self.stockChange = stockChange
        self.isRising = isRising
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.backgroundColor = NSColor(red:0.211, green:0.211, blue:0.211, alpha:1).cgColor
        layer?.cornerRadius = 4

        // Drawing code here.
        stockNameView.frame = NSRect(x: 0, y: 0, width: 70, height: 30)
        let nameCell = VerticalNSTextFieldCell.init(textCell: stockName)
        nameCell.alignment = .center
        stockNameView.cell = nameCell
        
        stockPriceView.frame = NSRect(x: 70, y: 0, width: 70, height: 30)
        let priceCell = VerticalNSTextFieldCell.init(textCell: stockPrice)
        priceCell.alignment = .center
        stockPriceView.cell = priceCell
        
        stockDeltaBackgroundView.frame = NSRect(x: 140, y: 0, width: 70, height: 30)
        stockDeltaBackgroundView.wantsLayer = true
        stockDeltaBackgroundView.layer?.backgroundColor = isRising ? NSColor.red.cgColor : NSColor.green.cgColor
        stockDeltaBackgroundView.layer?.cornerRadius = 4
        
        stockDeltaView.frame = NSRect(x: 140, y: 0, width: 70, height: 30)
        let deltaCell = VerticalNSTextFieldCell.init(textCell: stockChange)
        deltaCell.alignment = .center
        stockDeltaView.cell = deltaCell
        
        addSubview(stockNameView)
        addSubview(stockPriceView)
        addSubview(stockDeltaBackgroundView)
        addSubview(stockDeltaView)
    }
    
}
