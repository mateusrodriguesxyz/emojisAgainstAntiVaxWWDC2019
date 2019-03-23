//#-hidden-code
import PlaygroundSupport
import UIKit
import SpriteKit

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

func start() {
    let message: PlaygroundValue = .integer(1)
    remoteView.send(message)
}

//#-end-hidden-code

/*:
 
 ## The immune system
 In simple words, our immune system produces several types of cells responsible for defending our body and two of these very important cells are **B lymphocytes** and **T lymphocytes**. T lymphocytes are responsible for identifying intruders, called **antigens**, and then alerting B lymphocytes which produce **antibodies** to each specific antigen.
 
 ## Vaccines
As some diseases are really dangerous, it is possible to induce the production of antibodies using **vaccines** to inject **dead** or **weakened** antigens into the body. These antigens will not cause the disease but will leave the body prepared for a real attack!
 
 &nbsp;
 
 - Experiment:
 You're gonna help the lymphocites.
    1. Click on _Tap to Enter Code_,
    3. Select **start()** function,
    2. Click on _Run my code_,
    3. Click on the antygen 🦠 so the T lymphcytes can identify it,
    3. The B lymphocytes will produce antibodies 💂‍♂️ to destroy the antygen!
 
 &nbsp;
 
 - Note:
    If you're wondering, yes, the pacient it's british. 🇬🇧
 
*/
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, start())
//#-editable-code Tap to Enter Code
//#-end-editable-code
//:[Next: Cracking Myths](@next)




