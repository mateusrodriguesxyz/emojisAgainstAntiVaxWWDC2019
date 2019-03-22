//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class PageFourViewController: UIViewController {
    
    public let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var spriteScene: SceneFour?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spriteScene = SceneFour(size: view.bounds.size)
        spriteScene?.scaleMode = .resizeFill
        let skView = SKView(frame: CGRect(origin: CGPoint.zero, size: view.bounds.size))
        skView.isUserInteractionEnabled = true
        skView.backgroundColor = UIColor.red
        skView.presentScene(spriteScene)
        
        skView.showsPhysics = true
        
        self.view.addSubview(skView)
    }
    
}

extension PageFourViewController: PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer  {
    public func receive(_ message: PlaygroundValue) {
        
        guard let scene = spriteScene else { return }
        
        guard case let .dictionary(values) = message else {
            scene.logLabel.text = "Dictionary not available"
            return
        }
        
        guard case let .string(action)? = values["action"] else {
            scene.logLabel.text = "Action not found"
            return
        }
        
        guard case let .string(target)? = values["target"] else {
            scene.logLabel.text = "Target not found"
            return
        }
        
        switch action {
        case "infect":
            spriteScene?.infectPerson(named: target)
        case "vacinate":
            spriteScene?.vacinatePerson(named: target)
        default:
            print("nothing")
        }
        
        
    }
}

