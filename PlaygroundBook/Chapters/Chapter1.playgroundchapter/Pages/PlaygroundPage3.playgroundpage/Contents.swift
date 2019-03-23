//#-hidden-code
import PlaygroundSupport
import UIKit
import SpriteKit

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

func create(total: Int) {
    let action = PlaygroundValue.string("create")
    let total = PlaygroundValue.integer(total)
    let message = PlaygroundValue.dictionary(["action": action, "total": total])
    remoteView.send(message)
}

//#-end-hidden-code

/*:
 
 ##The Anti-Vax Movement
 
 Vaccines are one of the greatest achievements of medicine but unfortunately there is a growing movement of people standing against vaccination because of misinformation. Let's break some of these myths!
 
 
 - Experiment:
 It's Immunization Day, so let's vaccinate a few emojis.
 1. Click on "Run My Code",
 2. Click on emojis to vaccinate them
 3. Some may cry a little or get a little sick but in the end everyone will be healthy and happy. 😀
 
 */

//#-code-completion(everything, hide)
create(<#T##number of emojis##Int#>)

//:[Next: The Zombie Apocalipse](@next)
 
 
