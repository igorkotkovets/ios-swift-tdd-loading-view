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
    let drawFPS: String = "FPS: %@"
    let drawFPSAttrs: [String : Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 12),
                        NSForegroundColorAttributeName: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                        NSBackgroundColorAttributeName: UIColor.clear]
    let viewSize: CGSize = CGSize(width: 100, height: 30)
    let framesManager: FramesManager = FramesManager()

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

    override public func layoutSubviews() {
        super.layoutSubviews()

        let origSize = self.frame.size
        self.frame = self.frame.insetBy(dx: (origSize.width-viewSize.width)/2.0,
                                        dy: (origSize.height-viewSize.height)/2.0).integral
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        drawFPS.draw(in: rect, withAttributes: drawFPSAttrs)
    }

}
