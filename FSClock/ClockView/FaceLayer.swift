// FaceLayer.swift

import UIKit

class FaceLayer: CALayer {
    let lineCap = CGLineCap.round
    let color = UIColor.white
    
    override func draw(in ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        
        // move to center
        ctx.translateBy(x: self.bounds.width/2, y: self.bounds.height/2)
        
        // draw lines
        ctx.setStrokeColor(self.color.cgColor)
        ctx.setLineCap(self.lineCap)
        for step in 0...59 {
            let boldLine = Float(step).remainder(dividingBy: 5) == 0
            ctx.setLineWidth(boldLine ? 4 : 2)
            ctx.move(to: CGPoint(x: self.bounds.width/2 - (boldLine ? 25 : 20), y: 0))
            ctx.addLine(to: CGPoint(x: self.bounds.width/2 - 10, y: 0))
            ctx.strokePath()
            
            ctx.rotate(by: CGFloat.pi/30)
        }
    }
}
