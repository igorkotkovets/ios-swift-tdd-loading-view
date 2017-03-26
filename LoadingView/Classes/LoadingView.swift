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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.viewComputations = ViewComputations()
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

        startDisplayLinkIfNeeded()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        if framesManager.canGo() {
            if let ctx = UIGraphicsGetCurrentContext() {
                drawFPS(ctx)
            }
            print("draw")
        }
        else {
            print("skipped")
        }
        

        framesManager.frame()
    }

    @objc private func tick(sender: CADisplayLink) {
        self.setNeedsDisplay()
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
        context.translateBy(x: 0, y: self.bounds.size.height);
        context.scaleBy(x: 1, y: -1);
        CTFrameDraw(frame, context)
    }

}
