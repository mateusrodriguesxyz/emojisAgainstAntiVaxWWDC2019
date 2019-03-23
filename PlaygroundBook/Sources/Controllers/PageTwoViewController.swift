//
//  PageTwoViewController.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class PageTwoViewController: UIViewController {
    
    public var spriteScene: SceneTwo?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spriteScene = SceneTwo(size: view.bounds.size)
        spriteScene?.scaleMode = .resizeFill
        let skView = SKView(frame: CGRect(origin: CGPoint.zero, size: view.bounds.size))
        skView.isUserInteractionEnabled = true
        skView.presentScene(spriteScene)
        
        skView.showsPhysics = true
        
        self.view.addSubview(skView)
        
    }
    
}

extension PageTwoViewController: PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer  {
    public func receive(_ message: PlaygroundValue) {
        
        guard let scene = spriteScene else { return }
        
        switch message {
        case .string("start"):
            scene.start()
        default:
            return
        }
        
    }
}
