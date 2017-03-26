//
//  LoadingView.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/19/17.
//
//

import UIKit

public class LoadingView: UIView {
    var viewComputations: ViewComputations?
    let drawFPS: String = "FPS: %d"
    let drawFPSAttrs: [String : Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 12),
                        NSForegroundColorAttributeName: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                        NSBackgroundColorAttributeName: UIColor.clear]
    let viewSize: CGSize = CGSize(width: 100, height: 100)
    let framesManager: FramesManager = FramesManager()
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

        let fpsString = String(format: drawFPS, framesManager.fps())
        fpsString.draw(in: self.bounds, withAttributes: drawFPSAttrs)
    }

    @objc private func tick(sender: CADisplayLink) {

        framesManager.frame(current: sender.timestamp)
        self.setNeedsDisplay()
    }

}
