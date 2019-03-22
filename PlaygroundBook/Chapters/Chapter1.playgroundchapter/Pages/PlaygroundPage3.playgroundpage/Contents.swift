import PlaygroundSupport
import UIKit
import SpriteKit

//#-hidden-code

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

func infect(_ name: String) {
    let action = PlaygroundValue.string("infect")
    let target = PlaygroundValue.string(name)
    let message = PlaygroundValue.dictionary(["action": action, "target": target])
    remoteView.send(message)
}

func vacinate(_ name: String) {
    let action = PlaygroundValue.string("vacinate")
    let target = PlaygroundValue.string(name)
    let message = PlaygroundValue.dictionary(["action": action, "target": target])
    remoteView.send(message)
}

//#-end-hidden-code

var 👩🏻‍🦱 = "jessica"
var 🧑🏽 = "cibele"

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, 👩🏻‍🦱, 🧑🏽)

infect("jessica")
vacinate("cibele")
