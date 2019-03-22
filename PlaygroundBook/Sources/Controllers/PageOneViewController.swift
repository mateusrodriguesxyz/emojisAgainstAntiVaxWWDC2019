//
//  PageOneViewController.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class PageOneViewController: UIViewController {
    
    public var spriteScene: SceneOne?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spriteScene = SceneOne(size: view.bounds.size)
        spriteScene?.scaleMode = .resizeFill
        let skView = SKView(frame: CGRect(origin: CGPoint.zero, size: view.bounds.size))
        skView.isUserInteractionEnabled = true
        skView.presentScene(spriteScene)
        
        skView.showsPhysics = true
        
        self.view.addSubview(skView)
    }
    
}

extension PageOneViewController: PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer  {
    public func receive(_ message: PlaygroundValue) {
        
    }
}
