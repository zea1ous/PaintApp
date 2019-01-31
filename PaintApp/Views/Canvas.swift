//
//  Canvas.swift
//  PaintApp
//
//  Created by Alex Kolovatov on 31/01/2019.
//  Copyright © 2019 Alex Kolovatov. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    private var lines = [Line]()
    private var strokeColor: UIColor = .black
    private var strokeWidth: Float = 1
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
 
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth((CGFloat(line.strokeWidth)))
            context.setLineCap(.round)
            
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            
            context.strokePath()
        }
    }
    
    // MARK: - Public Actions
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeColor(color: UIColor) {
        strokeColor = color
    }
    
    func setStrokeWidth(_ width: Float) {
        strokeWidth = width
    }
    
    // track the finger as we move across the screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
}

