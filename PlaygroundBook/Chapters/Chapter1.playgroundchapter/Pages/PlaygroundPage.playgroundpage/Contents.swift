//#-hidden-code

import PlaygroundSupport
import SpriteKit

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

//#-end-hidden-code
/*:
 
 - Experiment:
 You're gonna help the lymphocites.
 1. Click on "Run My Code",
 2. Click on the antygen so the T lymphcytes can identify it,
 3. The B lymphocytes will produce antibodies to destroy the antygen!
 */

//: [Next: How It Works](@next)



