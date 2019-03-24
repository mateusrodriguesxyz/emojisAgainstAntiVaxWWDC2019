//#-hidden-code
import PlaygroundSupport
import UIKit
import SpriteKit

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
/*:
 ## Avoiding the spread of diseases
 
 We can never guarantee that a disease will never appear again, so it is a community effort to prevent diseases from coming back, and vaccines are our weapon in this war. Imagine if most of the parents stopped vaccinating their children against measles because of false news, we would have a measles outbreak. Now imagine if the same happened to a zombie virus, it would be a nightmare, a zombie apocalypse!
 
 
 - Experiment:
 You're gonna help to avoid the spread of a zombie virus!
    1. Click on _Tap to Enter Code_
    2. Select **infect()** function
    3. Enter the name or emoji of a person, this will be the pacient zero
    4. Click on _Run My Code_
    5. Click on emojis to vaccinate them and stop the virus to spread
 
 &nbsp;
 
 - Note:
 You can't let the zombies outnumber humans or there will be a apocalypse! 😱
 
 */

var 👩🏻‍🦱 = "jessica"
var 🧔🏼 = "thalys"

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, infect(_:), 👩🏻‍🦱, 🧔🏼)
/*#-editable-code Tap to enter code*//*#-end-editable-code*/
//:[Next: About Me / References](@next)

