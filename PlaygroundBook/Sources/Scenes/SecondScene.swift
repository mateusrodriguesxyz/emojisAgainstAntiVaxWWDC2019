//
//  FirstScene.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 16/03/19.
//

import SpriteKit
import GameplayKit

public class SecondScene: SKScene {
    
    private var entityManager: EntityManager!
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    private var people: [Person] = []
    
    lazy var logLabel: SKLabelNode = {
        let label = SKLabelNode(text: "Log")
        label.fontColor = UIColor.black
        label.fontSize = 25
        label.position = CGPoint(x: self.frame.minX + label.frame.width/2 + 5,
                                 y: self.frame.maxY - 25)
        return label
    }()
    
    private var filledRange = [PointRange]()
    
    override public init(size: CGSize) {
        
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        addChild(logLabel)
        
        entityManager = EntityManager(scene: self)
        
        self.people = [Person(entityManager: entityManager, name: "cibele", gender: .female, emoji: "🧑🏽"),
                       Person(entityManager: entityManager, name: "", gender: .male, emoji: "👨🏼‍🦰"),
                       Person(entityManager: entityManager, name: "jessica", gender: .female, emoji: "👩🏻‍🦱"),
                       Person(entityManager: entityManager, name: "4", gender: .male, emoji: "👨🏿‍🦱"),
                       Person(entityManager: entityManager, name: "5", gender: .male, emoji: "🧔🏼")]
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        
        backgroundColor = UIColor.white
        
        physicsWorld.contactDelegate = self
        
        people.enumerated().forEach { (i, person) in
            if i == 1 {
                person.infect()
            }
            entityManager.add(person)
        }
        
        setValidSpritePosition(entities: people, offset: 100, initialRanges: filledRange)
        
    }
    
    private func setValidSpritePosition(entities: [GKEntity], offset: CGFloat, initialRanges: [PointRange]) {
        
        if scene!.frame.width == 0 {
            return
        }
        
        var lastPosition: CGPoint = .zero
        var ranges = initialRanges
        
        entities.forEach { entity in
            let spriteComponent = entity.spriteComponent
            let node = spriteComponent.node
            var position = lastPosition
            
            while self.checkPositionInRange(position: position, ranges: ranges) {
                position = CGPoint.random(for: scene!.frame, offset: 50)
            }
            
            node.position = position
            lastPosition = node.position
            ranges.append(spriteComponent.getPointRange(offset: offset))

        }
        filledRange = ranges
    }
    
    private func checkPositionInRange(position: CGPoint, ranges: [PointRange]) -> Bool {
        for range in ranges {
            if range.contains(position) {
                return true
            }
        }
        return false
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let node = self.atPoint(location)
        if let person = node.entity as? Person {
            person.vacinate()
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager.update(deltaTime)
    }
    
    public func infectPerson(named name: String) {
        guard let person = self.people.first(where: {$0.name == name}) else { return }
        person.infect()
    }
    
    public func vacinatePerson(named name: String) {
        guard let person = self.people.first(where: {$0.name == name}) else { return }
        person.vacinate()
    }
    
}

extension SecondScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        guard let personA = contact.bodyA.node?.entity as? Person else {
            return
        }
        guard let personB = contact.bodyB.node?.entity as? Person else {
            return
        }
        
        if personA.isInfected {
            testInfection(zombie: personA, human: personB)
        }
        else if personB.isInfected {
           testInfection(zombie: personB, human: personA)
        }
    }
    
    private func testInfection(zombie: Person, human: Person) {
        if !human.isVacinated {
            human.infect()
        } else {
            if !human.wasTouched {
                human.wasTouched = true
                FollowComponent.vacinatedPeople.insert(human)
                createBalloon(for: human.spriteComponent.node)
            }
        }
        
        zombie.followComponent.behavior = nil
    }
    
    private func createBalloon(for node: SKNode) {
        let balloon = SKSpriteNode(imageNamed: "speak")
        balloon.setScale(0.5)
        let xPos = node.frame.maxX + balloon.frame.width/2
        let yPos = node.frame.maxY + balloon.frame.height/2
        let position = CGPoint(x: xPos , y: yPos)
        balloon.position = position
        addChild(balloon)
        let tongue = SKSpriteNode(imageNamed: "tongue")
        tongue.position = CGPoint.zero
        tongue.setScale(0.3)
        tongue.zPosition = 10
        balloon.addChild(tongue)
    }
    
    private func createLabel(for node: SKNode) {
        let label = SKLabelNode(text: "VACCINES ROCKS!")
        label.fontColor = UIColor.black
        label.fontSize = 20
        let xPos = node.frame.maxX + label.frame.width/2
        let yPos = node.frame.maxY
        let position = CGPoint(x: xPos , y: yPos)
        label.position = position
        addChild(label)
    }
    
    
}
