//
//  FirstScene.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 16/03/19.
//

import SpriteKit
import GameplayKit

public class SceneFour: SKScene {
    
    private var entityManager: EntityManager!
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    private var people: [Person] = []
    
    private var filledRange = [PointRange]()
    
    lazy var resultLabel: SKLabelNode = {
        let label = SKLabelNode(text: "RESULT")
        label.fontName = "AvenirNext-Bold"
        label.fontColor = UIColor.darkGray
        label.position = CGPoint.zero
        label.zPosition = 10
        label.alpha = 0
        return label
    }()
    
    private var start = false
    
    override public init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        entityManager = EntityManager(scene: self)
        
        self.people = [Person(entityManager: entityManager, name: "cibele", gender: .female, emoji: "🧑🏽"),
                       Person(entityManager: entityManager, name: "daniel", gender: .male, emoji: "👨🏼‍🦰"),
                       Person(entityManager: entityManager, name: "jessica", gender: .female, emoji: "👩🏻‍🦱"),
                       Person(entityManager: entityManager, name: "alan", gender: .male, emoji: "👨🏿‍🦱"),
                       Person(entityManager: entityManager, name: "thalys", gender: .male, emoji: "🧔🏼")]
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        physicsWorld.contactDelegate = self
        addChild(resultLabel)
        
        people.enumerated().forEach { (i, person) in
            entityManager.add(person)
        }
        
        setValidSpritePosition(entities: people, offset: 100, initialRanges: filledRange)
    }
    
    public func apocalipse(_ result: Bool){
        self.children.forEach {$0.alpha = 0.25}
        resultLabel.alpha = 1
        if result == true {
            resultLabel.text = "ZOMBIE APOCALIPSE!"
        } else {
            resultLabel.text = "YOU STOPPED THE VIRUS!"
        }
    }
    
    private func setValidSpritePosition(entities: [GKEntity], offset: CGFloat, initialRanges: [PointRange]) {
        
        if scene!.frame.width == 0 { return }
        
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
        
        if !start { return }
        
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let node = self.atPoint(location)
        if let person = node.entity as? Person {
            person.vacinate(animate: false, circle: true)
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
        self.start = true
    }
    
    public func vacinatePerson(named name: String) {
        guard let person = self.people.first(where: {$0.name == name}) else { return }
        person.vacinate()
    }
    
}

extension SceneFour: SKPhysicsContactDelegate {
    
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
                ZombieComponent.vacinatedPeople.insert(human)
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
