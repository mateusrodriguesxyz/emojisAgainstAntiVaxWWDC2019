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

//#-end-hidden-code

var 👩🏻‍🦱 = "jessica"
var 🧑🏽 = "cibele"

/*:
 
 ## Avoiding the Apocalipse
 
 - Experiment:
 You're gonna help to avoid the spread of a zombie virus!
 1. Click on _Tap to Enter Code_,
 2. Select **infect()** function,
 3. Enter the name or emoji of a person,
 4. Click on _Run My Code_,
 5. Click on emojis to vaccinate them and stop the virus to spread
 
 &nbsp;
 
 - Note:
 Some may cry a little or get a little sick but in the end everyone will be healthy and happy. 😀
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, infect(), 👩🏻‍🦱, 🧑🏽)
//#-editable-code Tap to enter code
//#-end-editable-code
//:[Next: About Me](@next)

