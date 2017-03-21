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
    override init(frame: CGRect) {
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
        
        
    }
}
