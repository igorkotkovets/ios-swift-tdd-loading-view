//
//  LoadingView.swift
//  Pods
//
//  Created by igork on 3/20/17.
//
//

import UIKit

class LoadingView: UIView {
    var viewComputations: ViewComputations?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = frame.insetBy(dx: self.frame.size.width-100, dy: self.frame.size.height-100)
    }

}
