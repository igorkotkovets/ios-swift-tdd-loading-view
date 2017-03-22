//: Playground - noun: a place where people can play

import XCPlayground
import UIKit
import LoadingView
import PlaygroundSupport

var loadingView = LoadingView(frame:CGRect(x: 0, y: 0, width: 400, height: 400))

PlaygroundPage.current.liveView = loadingView
