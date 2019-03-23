//
//  PageFiveViewController.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 23/03/19.
//

import UIKit
import PlaygroundSupport

public class PageFiveViewController: UIViewController {
    
    lazy var photoView: UIImageView = {
        let image = UIImage(named: "photo.jpg")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "😁💻🇧🇷"
        label.font = label.font.withSize(75)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoView)
        view.addSubview(label)
        photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        photoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 50).isActive = true
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoView.layer.cornerRadius = photoView.frame.width/2
    }
    
}

extension PageFiveViewController: PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer  {
    public func receive(_ message: PlaygroundValue) {
        
    }
}
