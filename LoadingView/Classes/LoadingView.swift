//
//  LoadingView.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/19/17.
//
//

import UIKit
import CoreText

public class LoadingView: UIView {
    var viewComputations: ViewComputations?
    let drawFPS: String = "FPS: %d"
    let drawFPSAttrs: [String : Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 12),
                        NSForegroundColorAttributeName: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                        NSBackgroundColorAttributeName: UIColor.clear]
    let viewSize: CGSize = CGSize(width: 100, height: 100)
    let framesManager: FramesManager = FramesManager(RealTimestampProvider())
    var displayLink: CADisplayLink?
    let timestampProvider: TimestampProvider = RealTimestampProvider()
    var midY: CGFloat = 0.0
    var centerX0: CGFloat = 0.0
    var centerX1: CGFloat = 0.0
    var centerX2: CGFloat = 0.0
    var dotRadius: CGFloat = 5.0

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.viewComputations = ViewComputations(animation: 1)
    }

    private func startDisplayLinkIfNeeded() {
        if displayLink != nil {
            return
        }

        displayLink = CADisplayLink(target: self, selector: #selector(tick))
        displayLink?.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        let origSize = self.frame.size
        self.frame = self.frame.insetBy(dx: (origSize.width-viewSize.width)/2.0,
                                        dy: (origSize.height-viewSize.height)/2.0).integral
        midY = self.bounds.midY
        centerX0 = 1*self.bounds.width/4
        centerX1 = 2*self.bounds.width/4
        centerX2 = 3*self.bounds.width/4

        startDisplayLinkIfNeeded()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        if let ctx = UIGraphicsGetCurrentContext() {
            drawFPS(ctx)
            let timestamp = timestampProvider.timestamp()
            draw(dotAtX: centerX0,
                 y: midY/2+self.bounds.midY*viewComputations!.getYPosition(afterTime: timestamp),
                 radius: dotRadius,
                 in: ctx)
            draw(dotAtX: centerX1,
                 y: midY/2+self.bounds.midY*viewComputations!.getYPosition(afterTime: timestamp),
                 radius: dotRadius,
                 in: ctx)
            draw(dotAtX: centerX2,
                 y: midY/2+self.bounds.midY*viewComputations!.getYPosition(afterTime: timestamp),
                 radius: dotRadius,
                 in: ctx)
        }
    }

    @objc private func tick(sender: CADisplayLink) {
        if framesManager.canGo() {
            self.setNeedsDisplay()
        }

        framesManager.frame()
    }

    private func drawFPS(_ context: CGContext) {
        let fpsString = String(format: drawFPS, framesManager.fps())
        let fpsAttributedString = NSAttributedString(string: fpsString, attributes: drawFPSAttrs)
        let path = CGMutablePath()
        path.addRect(self.bounds)
        let framesetter = CTFramesetterCreateWithAttributedString(fpsAttributedString)
        let frame = CTFramesetterCreateFrame(framesetter,
                                             CFRangeMake(0, fpsString.lengthOfBytes(using: .utf8)),
                                             path, nil)
        context.translateBy(x: 0, y: self.bounds.size.height)
        context.scaleBy(x: 1, y: -1)
        CTFrameDraw(frame, context)
        path.closeSubpath()
    }

    private func draw(dotAtX xCenter: CGFloat, y yCenter: CGFloat, radius fRadius: CGFloat, in context: CGContext) {
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xCenter, y: yCenter),
                    radius: fRadius,
                    startAngle: 0, endAngle: CGFloat.pi*2,
                    clockwise: true)
        path.closeSubpath()
        context.addPath(path)
        context.setFillColor(UIColor.green.cgColor)
        context.fillPath()
    }

}
