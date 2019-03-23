import UIKit
import SpriteKit
import PlaygroundSupport

public class PageThreeViewController: UIViewController {
    
    public var spriteScene: SceneThree?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spriteScene = SceneThree(size: view.bounds.size)
        spriteScene?.scaleMode = .resizeFill
        let skView = SKView(frame: CGRect(origin: CGPoint.zero, size: view.bounds.size))
        skView.isUserInteractionEnabled = true
        skView.presentScene(spriteScene)
        self.view.addSubview(skView)
    }
    
}

extension PageThreeViewController: PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer  {
    public func receive(_ message: PlaygroundValue) {
        
        guard let scene = spriteScene else { return }
        
        guard case let .dictionary(values) = message else {
            return
        }
        
        guard case let .string(action)? = values["action"] else {
            return
        }
        
        guard case let .integer(total)? = values["total"] else {
            return
        }
        
        switch action {
        case "create":
            spriteScene?.createEmojis(total)
        default:
            return
        }
        
    }
}

