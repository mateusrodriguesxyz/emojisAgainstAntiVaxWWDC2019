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
 
 ## The Anti-Vax Movement
 
 Vaccines are one of the greatest achievements of medicine but unfortunately there is a growing movement of people standing against vaccination because of misinformation. Let's crack some of the myths about vaccines!
 
 ### Vaccines cause autism
 
 The 1998 study that raised concerns about a possible link between measles-mumps-rubella (MMR) vaccine and autism was retracted by the journal that published it because it was significantly flawed by bad science. There is no evidence to link vaccines as the cause of autism, period.
 
 ### You can actually get the disease from a vaccine
 
 A vaccine causing complete disease would be extremely unlikely. Most vaccine reactions are usually temporary and minor, such as a fever or sore arm. It is rare to experience a very serious health event following a vaccination. You are far more likely to be seriously injured by a vaccine-preventable disease than by a vaccine.
 
 ### I don’t need to vaccinate because all the other poeple around me are already immune
 
 Herd immunity occurs when a large population of a community is immunized against a contagious disease, reducing the chance of an outbreak.  However, if enough people rely on herd immunity as the method of preventing infection from vaccine-preventable diseases, herd immunity will soon disappear
 
 
 - Experiment:
 It's Immunization Day, so let's vaccinate a few emojis.
    1. Click on _Tap to Enter Code_,
    2. Select **create(total:)** function,
    3. Enter the number of emojis to be created,
    4. Click on _Run My Code_,
    5. Click on emojis to vaccinate them
 
  &nbsp;
 
 - Note:
    Some may cry a little or get a little sick but in the end everyone will be healthy and happy. 😀
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, create(total:))
//#-editable-code Tap to enter code
//#-end-editable-code
//:[Next: The Zombie Apocalipse](@next)
 
