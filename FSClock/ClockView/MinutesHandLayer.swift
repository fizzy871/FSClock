// MinutesHandLayer.swift

import UIKit

class MinutesHandLayer: CALayer {
    let length: CGFloat = 0.8
    let color = UIColor.yellow
    let lineWidth: CGFloat = 3
    let dotRadius: CGFloat = 6
    var minutes: CGFloat = 8
    
    override func draw(in ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        
        // move to start point
        ctx.translateBy(x: self.bounds.width/2, y: self.bounds.height/2) // move to center
        ctx.rotate(by: -CGFloat.pi/2) // rotate to 12h
        
        // rotate to minutes
        let percent: CGFloat = self.minutes/60.0
        let angle: CGFloat = CGFloat.pi*2*percent
        ctx.rotate(by: angle)
        
        // draw dot
        let dotPath = UIBezierPath(ovalIn: CGRect(x: -self.dotRadius, y: -self.dotRadius, width: self.dotRadius*2, height: self.dotRadius*2))
        self.color.set()
        dotPath.fill()
        // draw hand
        let handPath = UIBezierPath()
        handPath.move(to: CGPoint.zero)
        handPath.addLine(to: CGPoint(x: (self.bounds.width/2)*self.length, y: 0))
        self.color.set()
        handPath.lineWidth = self.lineWidth
        handPath.lineCapStyle = .round
        handPath.stroke()
    }
}
