//
//  GameScene.swift
//  Egerszegi_Steven_SokoFinal
//
//  Created by Period Three on 6/5/18.
//  Copyright © 2018 Period Three. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    /*
 This class is that the game operates in

     
 */
    
    
    var level: String = ""
    var levelSet: String = ""
    var levelArray: [String] = []
    var levelByLine:[String] = []
    var levelByChar: [[Character]] = []
    var player = SKSpriteNode(imageNamed: "player")
    var walls:[SKSpriteNode] = []
    var boxes:[SKSpriteNode] = []
    var targets:[SKSpriteNode] = []
    var spaces:[SKSpriteNode] = []
    var playerXY: [Int] = []
    var moves : [String] = []
    var scale:Double = 64
    var nameGrab: [String] = []
    var levelName:String = ""
    var levelNumber:String = ""
    var gameIsWon = false
    var checkArray:[Character] = []
    var leftBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "left")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "left")), disabledTexture: nil)
    var rightBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "right")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "right")), disabledTexture: nil)
    var upBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "up")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "up")), disabledTexture: nil)
    var downBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "down")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "down")), disabledTexture: nil)
    var zoomInBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "up")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "up")), disabledTexture: nil)
    var zoomOutBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "down")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "down")), disabledTexture: nil)
    var undoBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "undo")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "undo")), disabledTexture: nil)
    var restartBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "restart")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "restart")), disabledTexture: nil)
    var leftvBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "left")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "left")), disabledTexture: nil)
    var rightvBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "right")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "right")), disabledTexture: nil)
    var upvBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "up")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "up")), disabledTexture: nil)
    var downvBtn = SKButtonNode(normalTexture: SKTexture(image: #imageLiteral(resourceName: "down")), selectedTexture: SKTexture(image: #imageLiteral(resourceName: "down")), disabledTexture: nil)
    let cameraNode = SKCameraNode()
    var cameraScale:CGFloat = 1
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    var zoom = true
    //let myGroup = DispatchGroup()
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let filename = levelSet
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                //print(levels)
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        print("level set count \(levelArray.count-1)")
        
        nameGrab = level.components(separatedBy: .newlines)
        if nameGrab[1] != ""{
            levelName = nameGrab[1]
            levelNumber = nameGrab[0]
        }else{
            levelNumber = nameGrab[0]
        }
        levelByLine = level.components(separatedBy: .newlines)
        let levelNumberArray = levelNumber.components(separatedBy: " ")
        if Int(levelNumberArray[1]) != levelArray.count-1{
        for i in 1...levelByLine.count-4{
            levelByChar.append(Array(levelByLine[i+1]))
            }
        }else{
            for i in 1...levelByLine.count-3{
                levelByChar.append(Array(levelByLine[i+1]))
            }
        }
        
        if String(levelByChar[0]) == ""{
            levelByChar.remove(at: 0)
        }
        
        generateLevel()
        
        //cameraNode.position = CGPoint(x: player.position.x, y: player.position.y)
        cameraNode.setScale(1)
        scene?.addChild(cameraNode)
        scene?.camera = cameraNode
        
        leftBtn.position = CGPoint(x: -(frame.width/13.5), y: -(frame.height)/2.5)
        leftBtn.setScale(0.10)
        addChild(leftBtn)
        rightBtn.position = CGPoint(x: (frame.width/13.5), y: -(frame.height)/2.5)
        rightBtn.setScale(0.10)
        addChild(rightBtn)
        upBtn.position = CGPoint(x: frame.width/frame.width, y: -(frame.height)/2.75)
        upBtn.setScale(0.10)
        addChild(upBtn)
        downBtn.position = CGPoint(x: frame.width/frame.width, y: -(frame.height)/2.25)
        downBtn.setScale(0.10)
        addChild(downBtn)
        zoomInBtn.position = CGPoint(x: -(frame.width/2.5), y: -(frame.height)/2.25)
        zoomInBtn.setScale(0.10)
        addChild(zoomInBtn)
        zoomOutBtn.position = CGPoint(x: -(frame.width/2.5), y: -(frame.height)/2.75)
        zoomOutBtn.setScale(0.10)
        addChild(zoomOutBtn)
        undoBtn.position = CGPoint(x: -(frame.width/4), y: -(frame.height)/2.5)
        undoBtn.setScale(0.5)
        addChild(undoBtn)
        restartBtn.position = CGPoint(x: (frame.width/4), y: -(frame.height)/2.5)
        restartBtn.setScale(0.5)
        addChild(restartBtn)
        leftvBtn.position = CGPoint(x: (frame.width/2.8), y: -(frame.height)/2.5)
        leftvBtn.setScale(0.10)
        addChild(leftvBtn)
        rightvBtn.position = CGPoint(x: (frame.width/2.25), y: -(frame.height)/2.5)
        rightvBtn.setScale(0.10)
        addChild(rightvBtn)
        upvBtn.position = CGPoint(x: (frame.width/2.5), y: -(frame.height)/2.66)
        upvBtn.setScale(0.10)
        addChild(upvBtn)
        downvBtn.position = CGPoint(x: (frame.width/2.5), y: -(frame.height)/2.35)
        downvBtn.setScale(0.10)
        addChild(downvBtn)
        
        
        
        leftBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.leftAction))
        
        rightBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.rightAction))
        
        upBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.upAction))
        
        downBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.downAction))
        
        zoomInBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.zoomIn))
        
        zoomOutBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.zoomOut))
        
        undoBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.undo))
        
        restartBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.restartAction))
        
        leftvBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.leftvAction))
        
        rightvBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.rightvAction))
        
        upvBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.upvAction))
        
        downvBtn.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.downvAction))
        
        swipeRightRec.addTarget(self, action: #selector(GameScene.rightAction) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.leftAction) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        
        swipeUpRec.addTarget(self, action: #selector(GameScene.upAction) )
        swipeUpRec.direction = .up
        self.view!.addGestureRecognizer(swipeUpRec)
        
        swipeDownRec.addTarget(self, action: #selector(GameScene.downAction) )
        swipeDownRec.direction = .down
        self.view!.addGestureRecognizer(swipeDownRec)
        
        print("Boxes Array count\(boxes.count)")
    }
    
    @objc func goMenu(){
        
    }
    
    @objc func goLevel(){
        
    }
    
    @objc func leftvAction(){
        cameraNode.position = CGPoint(x: (Double(cameraNode.position.x))-Double(scale*Double(cameraScale)), y: Double(cameraNode.position.y))
         //rename xy to button position
        leftBtn.position = CGPoint(x: Double(leftBtn.position.x)-scale*Double(cameraScale), y: Double(leftBtn.position.y))
        rightBtn.position = CGPoint(x: Double(rightBtn.position.x)-scale*Double(cameraScale), y: Double(rightBtn.position.y))
        upBtn.position = CGPoint(x: Double(upBtn.position.x)-scale*Double(cameraScale), y: Double(upBtn.position.y))
        downBtn.position = CGPoint(x: Double(downBtn.position.x)-scale*Double(cameraScale), y: Double(downBtn.position.y))
        zoomInBtn.position = CGPoint(x: Double(zoomInBtn.position.x)-scale*Double(cameraScale), y: Double(zoomInBtn.position.y))
        zoomOutBtn.position = CGPoint(x: Double(zoomOutBtn.position.x)-scale*Double(cameraScale), y: Double(zoomOutBtn.position.y))
        undoBtn.position = CGPoint(x: Double(undoBtn.position.x)-scale*Double(cameraScale), y: Double(undoBtn.position.y))
        restartBtn.position = CGPoint(x: Double(restartBtn.position.x)-scale*Double(cameraScale), y: Double(restartBtn.position.y))
        leftvBtn.position = CGPoint(x: Double(leftvBtn.position.x)-scale*Double(cameraScale), y: Double(leftvBtn.position.y))
        rightvBtn.position = CGPoint(x: Double(rightvBtn.position.x)-scale*Double(cameraScale), y: Double(rightvBtn.position.y))
        upvBtn.position = CGPoint(x: Double(upvBtn.position.x)-scale*Double(cameraScale), y: Double(upvBtn.position.y))
        downvBtn.position = CGPoint(x: Double(downvBtn.position.x)-scale*Double(cameraScale), y: Double(downvBtn.position.y))
        zoom = false
    }
    
    @objc func rightvAction(){
        cameraNode.position = CGPoint(x: Double(cameraNode.position.x)+Double(scale*Double(cameraScale)), y: Double(cameraNode.position.y))
        leftBtn.position = CGPoint(x: Double(leftBtn.position.x)+scale*Double(cameraScale), y: Double(leftBtn.position.y))
        rightBtn.position = CGPoint(x: Double(rightBtn.position.x)+scale*Double(cameraScale), y: Double(rightBtn.position.y))
        upBtn.position = CGPoint(x: Double(upBtn.position.x)+scale*Double(cameraScale), y: Double(upBtn.position.y))
        downBtn.position = CGPoint(x: Double(downBtn.position.x)+scale*Double(cameraScale), y: Double(downBtn.position.y))
        zoomInBtn.position = CGPoint(x: Double(zoomInBtn.position.x)+scale*Double(cameraScale), y: Double(zoomInBtn.position.y))
        zoomOutBtn.position = CGPoint(x: Double(zoomOutBtn.position.x)+scale*Double(cameraScale), y: Double(zoomOutBtn.position.y))
        undoBtn.position = CGPoint(x: Double(undoBtn.position.x)+scale*Double(cameraScale), y: Double(undoBtn.position.y))
        restartBtn.position = CGPoint(x: Double(restartBtn.position.x)+scale*Double(cameraScale), y: Double(restartBtn.position.y))
        leftvBtn.position = CGPoint(x: Double(leftvBtn.position.x)+scale*Double(cameraScale), y: Double(leftvBtn.position.y))
        rightvBtn.position = CGPoint(x: Double(rightvBtn.position.x)+scale*Double(cameraScale), y: Double(rightvBtn.position.y))
        upvBtn.position = CGPoint(x: Double(upvBtn.position.x)+scale*Double(cameraScale), y: Double(upvBtn.position.y))
        downvBtn.position = CGPoint(x: Double(downvBtn.position.x)+scale*Double(cameraScale), y: Double(downvBtn.position.y))
        zoom = false
    }
    
    @objc func upvAction(){
        cameraNode.position = CGPoint(x: Double(cameraNode.position.x), y: Double(cameraNode.position.y)+Double(scale*Double(cameraScale)))
        leftBtn.position = CGPoint(x: Double(leftBtn.position.x), y: Double(leftBtn.position.y)+scale*Double(cameraScale))
        rightBtn.position = CGPoint(x: Double(rightBtn.position.x), y: Double(rightBtn.position.y)+scale*Double(cameraScale))
        upBtn.position = CGPoint(x: Double(upBtn.position.x), y: Double(upBtn.position.y)+scale*Double(cameraScale))
        downBtn.position = CGPoint(x: Double(downBtn.position.x), y: Double(downBtn.position.y)+scale*Double(cameraScale))
        zoomInBtn.position = CGPoint(x: Double(zoomInBtn.position.x), y: Double(zoomInBtn.position.y)+scale*Double(cameraScale))
        zoomOutBtn.position = CGPoint(x: Double(zoomOutBtn.position.x), y: Double(zoomOutBtn.position.y)+scale*Double(cameraScale))
        undoBtn.position = CGPoint(x: Double(undoBtn.position.x), y: Double(undoBtn.position.y)+scale*Double(cameraScale))
        restartBtn.position = CGPoint(x: Double(restartBtn.position.x), y: Double(restartBtn.position.y)+scale*Double(cameraScale))
        leftvBtn.position = CGPoint(x: Double(leftvBtn.position.x), y: Double(leftvBtn.position.y)+scale*Double(cameraScale))
        rightvBtn.position = CGPoint(x: Double(rightvBtn.position.x), y: Double(rightvBtn.position.y)+scale*Double(cameraScale))
        upvBtn.position = CGPoint(x: Double(upvBtn.position.x), y: Double(upvBtn.position.y)+scale*Double(cameraScale))
        downvBtn.position = CGPoint(x: Double(downvBtn.position.x), y: Double(downvBtn.position.y)+scale*Double(cameraScale))
        zoom = false
    }
    
    @objc func downvAction(){
        cameraNode.position = CGPoint(x: Double(cameraNode.position.x), y: Double(cameraNode.position.y)-Double(scale*Double(cameraScale)))
        leftBtn.position = CGPoint(x: Double(leftBtn.position.x), y: Double(leftBtn.position.y)-scale*Double(cameraScale))
        rightBtn.position = CGPoint(x: Double(rightBtn.position.x), y: Double(rightBtn.position.y)-scale*Double(cameraScale))
        upBtn.position = CGPoint(x: Double(upBtn.position.x), y: Double(upBtn.position.y)-scale*Double(cameraScale))
        downBtn.position = CGPoint(x: Double(downBtn.position.x), y: Double(downBtn.position.y)-scale*Double(cameraScale))
        zoomInBtn.position = CGPoint(x: Double(zoomInBtn.position.x), y: Double(zoomInBtn.position.y)-scale*Double(cameraScale))
        zoomOutBtn.position = CGPoint(x: Double(zoomOutBtn.position.x), y: Double(zoomOutBtn.position.y)-scale*Double(cameraScale))
        undoBtn.position = CGPoint(x: Double(undoBtn.position.x), y: Double(undoBtn.position.y)-scale*Double(cameraScale))
        restartBtn.position = CGPoint(x: Double(restartBtn.position.x), y: Double(restartBtn.position.y)-scale*Double(cameraScale))
        leftvBtn.position = CGPoint(x: Double(leftvBtn.position.x), y: Double(leftvBtn.position.y)-scale*Double(cameraScale))
        rightvBtn.position = CGPoint(x: Double(rightvBtn.position.x), y: Double(rightvBtn.position.y)-scale*Double(cameraScale))
        upvBtn.position = CGPoint(x: Double(upvBtn.position.x), y: Double(upvBtn.position.y)-scale*Double(cameraScale))
        downvBtn.position = CGPoint(x: Double(downvBtn.position.x), y: Double(downvBtn.position.y)-scale*Double(cameraScale))
        zoom = false
    }
    
    @objc func zoomIn(){
        /*cameraScale += 0.25
        cameraNode.setScale(cameraScale)
        leftBtn.position = CGPoint(x: leftBtn.position.x*cameraScale, y: leftBtn.position.y*cameraScale)
        rightBtn.position = CGPoint(x: rightBtn.position.x*cameraScale, y: rightBtn.position.y*cameraScale)
        upBtn.position = CGPoint(x: upBtn.position.x*cameraScale, y: upBtn.position.y*cameraScale)
        downBtn.position = CGPoint(x: downBtn.position.x*cameraScale, y: downBtn.position.y*cameraScale)
        zoomInBtn.position = CGPoint(x: zoomInBtn.position.x*cameraScale, y: zoomInBtn.position.y*cameraScale)
        zoomOutBtn.position = CGPoint(x: zoomOutBtn.position.x, y: zoomOutBtn.position.y*cameraScale)
        undoBtn.position = CGPoint(x: undoBtn.position.x*cameraScale, y: undoBtn.position.y*cameraScale)
        restartBtn.position = CGPoint(x: restartBtn.position.x*cameraScale, y: restartBtn.position.y*cameraScale)
        leftvBtn.position = CGPoint(x: leftvBtn.position.x*cameraScale, y: leftvBtn.position.y*cameraScale)
        rightvBtn.position = CGPoint(x: rightvBtn.position.x*cameraScale, y: rightvBtn.position.y*cameraScale)
        upvBtn.position = CGPoint(x: upvBtn.position.x*cameraScale, y: upvBtn.position.y*cameraScale)
        downvBtn.position = CGPoint(x: downvBtn.position.x*cameraScale, y: downvBtn.position.y*cameraScale)
        leftvBtn.setScale(0.10*cameraScale)
        rightvBtn.setScale(0.10*cameraScale)
        upvBtn.setScale(0.10*cameraScale)
        downvBtn.setScale(0.10*cameraScale)
        leftBtn.setScale(0.10*cameraScale)
        rightBtn.setScale(0.10*cameraScale)
        upBtn.setScale(0.10*cameraScale)
        downBtn.setScale(0.10*cameraScale)
        zoomInBtn.setScale(0.10*cameraScale)
        zoomOutBtn.setScale(0.10*cameraScale)
        undoBtn.setScale(0.5*cameraScale)
        restartBtn.setScale(0.5*cameraScale)
        print(cameraScale)
        /*
         leftBtn.position = CGPoint(x: leftBtn.position.x*cameraScale, y: leftBtn.position.y*cameraScale)
         rightBtn.position = CGPoint(x: rightBtn.position.x*cameraScale, y: rightBtn.position.y*cameraScale)
         upBtn.position = CGPoint(x: upBtn.position.x*cameraScale, y: upBtn.position.y*cameraScale)
         downBtn.position = CGPoint(x: downBtn.position.x*cameraScale, y: downBtn.position.y*cameraScale)
         zoomInBtn.position = CGPoint(x: zoomInBtn.position.x*cameraScale, y: zoomInBtn.position.y*cameraScale)
         zoomOutBtn.position = CGPoint(x: zoomOutBtn.position.x, y: zoomOutBtn.position.y*cameraScale)
         undoBtn.position = CGPoint(x: undoBtn.position.x*cameraScale, y: undoBtn.position.y*cameraScale)
         restartBtn.position = CGPoint(x: restartBtn.position.x*cameraScale, y: restartBtn.position.y*cameraScale)
         leftvBtn.position = CGPoint(x: leftvBtn.position.x*cameraScale, y: leftvBtn.position.y*cameraScale)
         rightvBtn.position = CGPoint(x: rightvBtn.position.x*cameraScale, y: rightvBtn.position.y*cameraScale)
         upvBtn.position = CGPoint(x: upvBtn.position.x*cameraScale, y: upvBtn.position.y*cameraScale)
         downvBtn.position = CGPoint(x: downvBtn.position.x*cameraScale, y: downvBtn.position.y*cameraScale)
         let theScale = leftBtn.xScale
         let otherScale = undoBtn.xScale
         leftvBtn.setScale(theScale*cameraScale)
         rightvBtn.setScale(theScale*cameraScale)
         upvBtn.setScale(theScale*cameraScale)
         downvBtn.setScale(theScale*cameraScale)
         leftBtn.setScale(theScale*cameraScale)
         rightBtn.setScale(theScale*cameraScale)
         upBtn.setScale(theScale*cameraScale)
         downBtn.setScale(theScale*cameraScale)
         zoomInBtn.setScale(theScale*cameraScale)
         zoomOutBtn.setScale(theScale*cameraScale)
         undoBtn.setScale(otherScale*cameraScale)
         restartBtn.setScale(otherScale*cameraScale)
         */ */
        if zoom == true {
        cameraScale += 0.25
        cameraNode.setScale(cameraScale)
        leftBtn.position = CGPoint(x: -(frame.width/13.5)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        rightBtn.position = CGPoint(x: (frame.width/13.5)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        upBtn.position = CGPoint(x: (frame.width/frame.width)*cameraScale, y: (-(frame.height)/2.75)*cameraScale)
        downBtn.position = CGPoint(x: (frame.width/frame.width)*cameraScale, y: (-(frame.height)/2.25)*cameraScale)
        zoomInBtn.position = CGPoint(x: -(frame.width/2.5)*cameraScale, y: (-(frame.height)/2.25)*cameraScale)
        zoomOutBtn.position = CGPoint(x: -(frame.width/2.5)*cameraScale, y: (-(frame.height)/2.75)*cameraScale)
        undoBtn.position = CGPoint(x: -(frame.width/4)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        restartBtn.position = CGPoint(x: (frame.width/4)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        leftvBtn.position = CGPoint(x: (frame.width/2.8)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        rightvBtn.position = CGPoint(x: (frame.width/2.25)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        upvBtn.position = CGPoint(x: (frame.width/2.5)*cameraScale, y: (-(frame.height)/2.66)*cameraScale)
        downvBtn.position = CGPoint(x: (frame.width/2.5)*cameraScale, y: (-(frame.height)/2.35)*cameraScale)
        leftvBtn.setScale(0.10*cameraScale)
        rightvBtn.setScale(0.10*cameraScale)
        upvBtn.setScale(0.10*cameraScale)
        downvBtn.setScale(0.10*cameraScale)
        leftBtn.setScale(0.10*cameraScale)
        rightBtn.setScale(0.10*cameraScale)
        upBtn.setScale(0.10*cameraScale)
        downBtn.setScale(0.10*cameraScale)
        zoomInBtn.setScale(0.10*cameraScale)
        zoomOutBtn.setScale(0.10*cameraScale)
        undoBtn.setScale(0.5*cameraScale)
        restartBtn.setScale(0.5*cameraScale)
        }
    }
    
    @objc func zoomOut(){
        if zoom == true {
        if cameraScale > 0.25{
        cameraScale -= 0.25
        cameraNode.setScale(cameraScale)
        leftBtn.position = CGPoint(x: -(frame.width/13.5)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        rightBtn.position = CGPoint(x: (frame.width/13.5)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        upBtn.position = CGPoint(x: (frame.width/frame.width)*cameraScale, y: (-(frame.height)/2.75)*cameraScale)
        downBtn.position = CGPoint(x: (frame.width/frame.width)*cameraScale, y: (-(frame.height)/2.25)*cameraScale)
        zoomInBtn.position = CGPoint(x: -(frame.width/2.5)*cameraScale, y: (-(frame.height)/2.25)*cameraScale)
        zoomOutBtn.position = CGPoint(x: -(frame.width/2.5)*cameraScale, y: (-(frame.height)/2.75)*cameraScale)
        undoBtn.position = CGPoint(x: -(frame.width/4)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        restartBtn.position = CGPoint(x: (frame.width/4)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        leftvBtn.position = CGPoint(x: (frame.width/2.8)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        rightvBtn.position = CGPoint(x: (frame.width/2.25)*cameraScale, y: (-(frame.height)/2.5)*cameraScale)
        upvBtn.position = CGPoint(x: (frame.width/2.5)*cameraScale, y: (-(frame.height)/2.66)*cameraScale)
        downvBtn.position = CGPoint(x: (frame.width/2.5)*cameraScale, y: (-(frame.height)/2.35)*cameraScale)
        leftvBtn.setScale(0.10*cameraScale)
        rightvBtn.setScale(0.10*cameraScale)
        upvBtn.setScale(0.10*cameraScale)
        downvBtn.setScale(0.10*cameraScale)
        leftBtn.setScale(0.10*cameraScale)
        rightBtn.setScale(0.10*cameraScale)
        upBtn.setScale(0.10*cameraScale)
        downBtn.setScale(0.10*cameraScale)
        zoomInBtn.setScale(0.10*cameraScale)
        zoomOutBtn.setScale(0.10*cameraScale)
        undoBtn.setScale(0.5*cameraScale)
        restartBtn.setScale(0.5*cameraScale)
        }
        print(cameraScale)
        }
    }
    
    @objc func restartAction(){
        
        let lx = leftBtn.position.x
        let ly = leftBtn.position.y
        let rx = rightBtn.position.x
        let ry = rightBtn.position.y
        let ux = upBtn.position.x
        let uy = upBtn.position.y
        let dx = downBtn.position.x
        let dy = downBtn.position.y
        let zix = zoomInBtn.position.x
        let ziy = zoomInBtn.position.y
        let zox = zoomOutBtn.position.x
        let zoy = zoomOutBtn.position.y
        let udx = undoBtn.position.x
        let udy = undoBtn.position.y
        let rsx = restartBtn.position.x
        let rsy = restartBtn.position.y
        let lvx = leftvBtn.position.x
        let lvy = leftvBtn.position.y
        let rvx = rightvBtn.position.x
        let rvy = rightvBtn.position.y
        let uvx = upvBtn.position.x
        let uvy = upvBtn.position.y
        let dvx = downvBtn.position.x
        let dvy = downvBtn.position.y
        let sl = leftBtn.xScale
        let rs = restartBtn.xScale
        
        removeChildren(in: boxes)
        removeChildren(in: walls)
        removeChildren(in: spaces)
        removeChildren(in: targets)
        for child in children{
            child.removeFromParent()
        }
        player.removeFromParent()
        levelByChar = []
        moves = []
        boxes = []
        spaces = []
        targets = []
        gameIsWon = false
        checkArray = []
        nameGrab = level.components(separatedBy: .newlines)
        if nameGrab[1] != ""{
            levelName = nameGrab[1]
            levelNumber = nameGrab[0]
        }else{
            levelNumber = nameGrab[0]
        }
        levelByLine = level.components(separatedBy: .newlines)
        let levelNumberArray = levelNumber.components(separatedBy: " ")
        if Int(levelNumberArray[1]) != levelArray.count-1{
            for i in 1...levelByLine.count-4{
                levelByChar.append(Array(levelByLine[i+1]))
            }
        }else{
            for i in 1...levelByLine.count-3{
                levelByChar.append(Array(levelByLine[i+1]))
            }
        }
        
        if String(levelByChar[0]) == ""{
            levelByChar.remove(at: 0)
        }
    
        
        leftBtn.position = CGPoint(x: lx, y: ly)
        addChild(leftBtn)
        rightBtn.position = CGPoint(x: rx, y: ry)
        addChild(rightBtn)
        upBtn.position = CGPoint(x: ux, y: uy)
        addChild(upBtn)
        downBtn.position = CGPoint(x: dx, y: dy)
        addChild(downBtn)
        zoomInBtn.position = CGPoint(x: zix, y: ziy)
        addChild(zoomInBtn)
        zoomOutBtn.position = CGPoint(x: zox, y: zoy)
        addChild(zoomOutBtn)
        undoBtn.position = CGPoint(x: udx, y: udy)
        addChild(undoBtn)
        restartBtn.position = CGPoint(x: rsx, y: rsy)
        leftvBtn.position = CGPoint(x: lvx, y: lvy)
        addChild(leftvBtn)
        rightvBtn.position = CGPoint(x: rvx, y: rvy)
        addChild(rightvBtn)
        upvBtn.position = CGPoint(x: uvx, y: uvy)
        addChild(upvBtn)
        downvBtn.position = CGPoint(x: dvx, y: dvy)
        addChild(downvBtn)
        leftvBtn.setScale(sl)
        rightvBtn.setScale(sl)
        upvBtn.setScale(sl)
        downvBtn.setScale(sl)
        leftBtn.setScale(sl)
        rightBtn.setScale(sl)
        upBtn.setScale(sl)
        downBtn.setScale(sl)
        zoomInBtn.setScale(sl)
        zoomOutBtn.setScale(sl)
        undoBtn.setScale(rs)
        restartBtn.setScale(rs)
        addChild(restartBtn)
        generateLevel()
 
    }
    
    @objc func undo(){
        if moves.last == "l"{
            rightAction()
            moves.removeLast()
            moves.removeLast()
        }else if moves.last == "r"{
            leftAction()
            moves.removeLast()
            moves.removeLast()
        }else if moves.last == "u"{
            downAction()
            moves.removeLast()
            moves.removeLast()
        }else if moves.last == "d"{
            upAction()
            moves.removeLast()
            moves.removeLast()
        }else if moves.last == "L"{
            playerXY = getPlayerPosition()
            let playerX = playerXY[0]
            let playerY = playerXY[1]
            print(playerX)
            print(playerY)
            let plX = player.position.x
            let plY = player.position.y
            let pos = getBoxPosition(direction: "L", pix: plX, piy: plY)
            
            if String(levelByChar[playerY][playerX+1]) == " "{
                levelByChar[playerY][playerX+1] = Character("@")
            }else if String(levelByChar[playerY][playerX+1]) == "."{
                levelByChar[playerY][playerX+1] = Character("+")
            }
            
            if String(levelByChar[playerY][playerX]) == "@"{
                levelByChar[playerY][playerX] = Character("$")
                boxes[pos].color = UIColor.clear
                boxes[pos].colorBlendFactor = 0
            } else if String(levelByChar[playerY][playerX]) == "+"{
                levelByChar[playerY][playerX] = Character("*")
                boxes[pos].color = UIColor.cyan
                boxes[pos].colorBlendFactor = 1
            }
            
            if String(levelByChar[playerY][playerX-1]) == "$"{
                levelByChar[playerY][playerX-1] = Character(" ")
            }else if String(levelByChar[playerY][playerX-1]) == "*"{
                levelByChar[playerY][playerX-1] = Character(".")
            }
            
            let bDestination = player.position.x
            let movingBox = SKAction.moveTo(x: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            animateCharacterr()
            
            
            moves.removeLast()
            
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
            
        }else if moves.last == "R"{
            playerXY = getPlayerPosition()
            let playerX = playerXY[0]
            let playerY = playerXY[1]
            print(playerX)
            print(playerY)
            let plX = player.position.x
            let plY = player.position.y
            let pos = getBoxPosition(direction: "R", pix: plX, piy: plY)
            
            if String(levelByChar[playerY][playerX-1]) == " "{
                levelByChar[playerY][playerX-1] = Character("@")
            }else if String(levelByChar[playerY][playerX-1]) == "."{
                levelByChar[playerY][playerX-1] = Character("+")
            }
            
            if String(levelByChar[playerY][playerX]) == "@"{
                levelByChar[playerY][playerX] = Character("$")
                boxes[pos].color = UIColor.clear
                boxes[pos].colorBlendFactor = 0
            } else if String(levelByChar[playerY][playerX]) == "+"{
                levelByChar[playerY][playerX] = Character("*")
                boxes[pos].color = UIColor.cyan
                boxes[pos].colorBlendFactor = 1
            }
            
            if String(levelByChar[playerY][playerX+1]) == "$"{
                levelByChar[playerY][playerX+1] = Character(" ")
            }else if String(levelByChar[playerY][playerX+1]) == "*"{
                levelByChar[playerY][playerX+1] = Character(".")
            }
            
            let bDestination = player.position.x
            let movingBox = SKAction.moveTo(x: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            animateCharacterl()
            
            
            moves.removeLast()
            
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
            
            
        }else if moves.last == "U"{
            playerXY = getPlayerPosition()
            let playerX = playerXY[0]
            let playerY = playerXY[1]
            print(playerX)
            print(playerY)
            let plX = player.position.x
            let plY = player.position.y
            let pos = getBoxPosition(direction: "U", pix: plX, piy: plY)
            
            if String(levelByChar[playerY+1][playerX]) == " "{
                levelByChar[playerY+1][playerX] = Character("@")
            }else if String(levelByChar[playerY+1][playerX]) == "."{
                levelByChar[playerY+1][playerX] = Character("+")
            }
            
            if String(levelByChar[playerY][playerX]) == "@"{
                levelByChar[playerY][playerX] = Character("$")
                boxes[pos].color = UIColor.clear
                boxes[pos].colorBlendFactor = 0
            } else if String(levelByChar[playerY][playerX]) == "+"{
                levelByChar[playerY][playerX] = Character("*")
                boxes[pos].color = UIColor.cyan
                boxes[pos].colorBlendFactor = 1
            }
            
            if String(levelByChar[playerY-1][playerX]) == "$"{
                levelByChar[playerY-1][playerX] = Character(" ")
            }else if String(levelByChar[playerY-1][playerX]) == "*"{
                levelByChar[playerY-1][playerX] = Character(".")
            }
            
            let bDestination = player.position.y
            let movingBox = SKAction.moveTo(y: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            animateCharacterd()
            
            
            moves.removeLast()
            
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
            
        }else if moves.last == "D"{
            playerXY = getPlayerPosition()
            let playerX = playerXY[0]
            let playerY = playerXY[1]
            print(playerX)
            print(playerY)
            let plX = player.position.x
            let plY = player.position.y
            let pos = getBoxPosition(direction: "D", pix: plX, piy: plY)
            
            if String(levelByChar[playerY-1][playerX]) == " "{
                levelByChar[playerY-1][playerX] = Character("@")
            }else if String(levelByChar[playerY-1][playerX]) == "."{
                levelByChar[playerY-1][playerX] = Character("+")
            }
            
            if String(levelByChar[playerY][playerX]) == "@"{
                levelByChar[playerY][playerX] = Character("$")
                boxes[pos].color = UIColor.clear
                boxes[pos].colorBlendFactor = 0
            } else if String(levelByChar[playerY][playerX]) == "+"{
                levelByChar[playerY][playerX] = Character("*")
                boxes[pos].color = UIColor.cyan
                boxes[pos].colorBlendFactor = 1
            }
            
            if String(levelByChar[playerY+1][playerX]) == "$"{
                levelByChar[playerY+1][playerX] = Character(" ")
            }else if String(levelByChar[playerY+1][playerX]) == "*"{
                levelByChar[playerY+1][playerX] = Character(".")
            }
            
            let bDestination = player.position.y
            let movingBox = SKAction.moveTo(y: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            animateCharacteru()
            
            
            moves.removeLast()
            
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
        }else{
            print("Can't undo")
        }
    }
    
    @objc func leftAction(){
        print("left")
        playerXY = getPlayerPosition()
        var playerX = playerXY[0]
        var playerY = playerXY[1]
        if String(levelByChar[playerY][playerX-1]) != "#"{
            if String(levelByChar[playerY][playerX-1]) == " " || String(levelByChar[playerY][playerX-1]) == "." {
                if levelByChar[playerY][playerX-1] == Character(" ") {
                levelByChar[playerY][playerX-1] = Character("@")
                }else if levelByChar[playerY][playerX-1] == Character("."){
                    levelByChar[playerY][playerX-1] = Character("+")
                }
                if levelByChar[playerY][playerX] == Character("@"){
                    levelByChar[playerY][playerX] = Character(" ")
                }else if levelByChar[playerY][playerX] == Character("+"){
                    levelByChar[playerY][playerX] = Character(".")
                }
                animateCharacterl()
                moves.append("l")
            }else if String(levelByChar[playerY][playerX-2]) != "$" || String(levelByChar[playerY][playerX-2]) != "*" || String(levelByChar[playerY][playerX-2]) != "#"{
                if String(levelByChar[playerY][playerX-1]) == "$" || String(levelByChar[playerY][playerX-1]) == "*"{
                    if String(levelByChar[playerY][playerX-2]) == "."{
                        levelByChar[playerY][playerX-2] = Character("*")
                        if levelByChar[playerY][playerX-1] == Character("$") {
                            levelByChar[playerY][playerX-1] = Character("@")
                        }else if levelByChar[playerY][playerX-1] == Character("*"){
                            levelByChar[playerY][playerX-1] = Character("+")
                        }
                    if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                    }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                    }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                    var pos = getBoxPosition(direction: "L", pix: plX, piy: plY)
                    animateBox(direction: "L", pos: pos)
                    boxes[pos].color = UIColor.cyan
                    boxes[pos].colorBlendFactor = 1
                    animateCharacterl()
                    moves.append("L")
                }else if String(levelByChar[playerY][playerX-2]) == " "{
                        levelByChar[playerY][playerX-2] = Character("$")
                        if levelByChar[playerY][playerX-1] == Character("$") {
                            levelByChar[playerY][playerX-1] = Character("@")
                        }else if levelByChar[playerY][playerX-1] == Character("*"){
                            levelByChar[playerY][playerX-1] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "L", pix: plX, piy: plY)
                        animateBox(direction: "L", pos: pos)
                        boxes[pos].color = UIColor.clear
                        boxes[pos].colorBlendFactor = 0
                        animateCharacterl()
                        moves.append("L")
                    }
        }
        
        
        }
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
        }else{
            //print("BAD MOVE")
            print(player.position)
        }
        
    }
    
    @objc func rightAction(){
        print("right")
        playerXY = getPlayerPosition()
        var playerX = playerXY[0]
        var playerY = playerXY[1]
        if String(levelByChar[playerY][playerX+1]) != "#"{
            if String(levelByChar[playerY][playerX+1]) == " " || String(levelByChar[playerY][playerX+1]) == "." {
                if levelByChar[playerY][playerX+1] == Character(" ") {
                    levelByChar[playerY][playerX+1] = Character("@")
                }else if levelByChar[playerY][playerX+1] == Character("."){
                    levelByChar[playerY][playerX+1] = Character("+")
                }
                if levelByChar[playerY][playerX] == Character("@"){
                    levelByChar[playerY][playerX] = Character(" ")
                }else if levelByChar[playerY][playerX] == Character("+"){
                    levelByChar[playerY][playerX] = Character(".")
                }
                animateCharacterr()
                moves.append("r")
            }else if String(levelByChar[playerY][playerX+2]) != "$" || String(levelByChar[playerY][playerX+2]) != "*" || String(levelByChar[playerY][playerX+2]) != "#"{
                if String(levelByChar[playerY][playerX+1]) == "$" || String(levelByChar[playerY][playerX+1]) == "*"{
                    if String(levelByChar[playerY][playerX+2]) == "."{
                        levelByChar[playerY][playerX+2] = Character("*")
                        if levelByChar[playerY][playerX+1] == Character("$") {
                            levelByChar[playerY][playerX+1] = Character("@")
                        }else if levelByChar[playerY][playerX+1] == Character("*"){
                            levelByChar[playerY][playerX+1] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "R", pix: plX, piy: plY)
                        animateBox(direction: "R", pos: pos)
                        boxes[pos].color = UIColor.cyan
                        boxes[pos].colorBlendFactor = 1
                        animateCharacterr()
                        moves.append("R")
                    }else if String(levelByChar[playerY][playerX+2]) == " "{
                        levelByChar[playerY][playerX+2] = Character("$")
                        if levelByChar[playerY][playerX+1] == Character("$") {
                            levelByChar[playerY][playerX+1] = Character("@")
                        }else if levelByChar[playerY][playerX+1] == Character("*"){
                            levelByChar[playerY][playerX+1] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "R", pix: plX, piy: plY)
                        animateBox(direction: "R", pos: pos)
                        boxes[pos].color = UIColor.clear
                        boxes[pos].colorBlendFactor = 0
                        animateCharacterr()
                        moves.append("R")
                    }
                }
                
            }
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
        }else{
         //   print("BAD MOVE")
        }
        checkGameState()
        print(player.position)
    }
    
    @objc func upAction(){
       print("up")
        playerXY = getPlayerPosition()
        var playerX = playerXY[0]
        var playerY = playerXY[1]
        if String(levelByChar[playerY-1][playerX]) != "#"{
            if String(levelByChar[playerY-1][playerX]) == " " || String(levelByChar[playerY-1][playerX]) == "." {
                if levelByChar[playerY-1][playerX] == Character(" ") {
                    levelByChar[playerY-1][playerX] = Character("@")
                }else if levelByChar[playerY-1][playerX] == Character("."){
                    levelByChar[playerY-1][playerX] = Character("+")
                }
                if levelByChar[playerY][playerX] == Character("@"){
                    levelByChar[playerY][playerX] = Character(" ")
                }else if levelByChar[playerY][playerX] == Character("+"){
                    levelByChar[playerY][playerX] = Character(".")
                }
                animateCharacteru()
                moves.append("u")
            }else if String(levelByChar[playerY-2][playerX]) != "$" || String(levelByChar[playerY-2][playerX]) != "*" || String(levelByChar[playerY-2][playerX]) != "#"{
                if String(levelByChar[playerY-1][playerX]) == "$" || String(levelByChar[playerY-1][playerX]) == "*"{
                    if String(levelByChar[playerY-2][playerX]) == "."{
                        levelByChar[playerY-2][playerX] = Character("*")
                        if levelByChar[playerY-1][playerX] == Character("$") {
                            levelByChar[playerY-1][playerX] = Character("@")
                        }else if levelByChar[playerY-1][playerX] == Character("*"){
                            levelByChar[playerY-1][playerX] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "U", pix: plX, piy: plY)
                        animateBox(direction: "U", pos: pos)
                        boxes[pos].color = UIColor.cyan
                        boxes[pos].colorBlendFactor = 1
                        animateCharacteru()
                        moves.append("U")
                    }else if String(levelByChar[playerY-2][playerX]) == " "{
                        levelByChar[playerY-2][playerX] = Character("$")
                        if levelByChar[playerY-1][playerX] == Character("$") {
                            levelByChar[playerY-1][playerX] = Character("@")
                        }else if levelByChar[playerY-1][playerX] == Character("*"){
                            levelByChar[playerY-1][playerX] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "U", pix: plX, piy: plY)
                        animateBox(direction: "U", pos: pos)
                        boxes[pos].color = UIColor.clear
                        boxes[pos].colorBlendFactor = 0
                        animateCharacteru()
                        moves.append("U")
                    }
                }
            }
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
        }else{
            //print("BAD MOVE")
        }
        checkGameState()
        print(player.position)
    }
    
    @objc func downAction(){
        print("down")
        playerXY = getPlayerPosition()
        var playerX = playerXY[0]
        var playerY = playerXY[1]
        if String(levelByChar[playerY+1][playerX]) != "#"{
            if String(levelByChar[playerY+1][playerX]) == " " || String(levelByChar[playerY+1][playerX]) == "." {
                if levelByChar[playerY+1][playerX] == Character(" ") {
                    levelByChar[playerY+1][playerX] = Character("@")
                }else if levelByChar[playerY+1][playerX] == Character("."){
                    levelByChar[playerY+1][playerX] = Character("+")
                }
                if levelByChar[playerY][playerX] == Character("@"){
                    levelByChar[playerY][playerX] = Character(" ")
                }else if levelByChar[playerY][playerX] == Character("+"){
                    levelByChar[playerY][playerX] = Character(".")
                }
                animateCharacterd()
                moves.append("d")
            }else if String(levelByChar[playerY+2][playerX]) != "$" || String(levelByChar[playerY+2][playerX]) != "*" || String(levelByChar[playerY+2][playerX]) != "#"{
                if String(levelByChar[playerY+1][playerX]) == "$" || String(levelByChar[playerY+1][playerX]) == "*"{
                    if String(levelByChar[playerY+2][playerX]) == "."{
                        levelByChar[playerY+2][playerX] = Character("*")
                        if levelByChar[playerY+1][playerX] == Character("$") {
                            levelByChar[playerY+1][playerX] = Character("@")
                        }else if levelByChar[playerY+1][playerX] == Character("*"){
                            levelByChar[playerY+1][playerX] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        print(playerX)
                        print(playerY)
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "D", pix: plX, piy: plY)
                        animateBox(direction: "D", pos: pos)
                        boxes[pos].color = UIColor.cyan
                        boxes[pos].colorBlendFactor = 1
                        animateCharacterd()
                        moves.append("D")
                    }else if String(levelByChar[playerY+2][playerX]) == " "{
                        levelByChar[playerY+2][playerX] = Character("$")
                        if levelByChar[playerY+1][playerX] == Character("$") {
                            levelByChar[playerY+1][playerX] = Character("@")
                        }else if levelByChar[playerY+1][playerX] == Character("*"){
                            levelByChar[playerY+1][playerX] = Character("+")
                        }
                        if levelByChar[playerY][playerX] == Character("@"){
                            levelByChar[playerY][playerX] = Character(" ")
                        }else if levelByChar[playerY][playerX] == Character("+"){
                            levelByChar[playerY][playerX] = Character(".")
                        }
                        playerXY = getPlayerPosition()
                        playerX = playerXY[0]
                        playerY = playerXY[1]
                        let plX = player.position.x
                        let plY = player.position.y
                        var pos = getBoxPosition(direction: "D", pix: plX, piy: plY)
                            self.animateBox(direction: "D", pos: pos)
                            self.boxes[pos].color = UIColor.clear
                            self.boxes[pos].colorBlendFactor = 0
                            self.animateCharacterd()
                            self.moves.append("D")
                        
                        
                    }
                }  
            }
            for i in 0...levelByChar.count-1{
                print(levelByChar[i])
            }
        }else{
            //print("BAD MOVE")
        }
        checkGameState()
        print(player.position)
    }

 
    func generateLevel(){
        for y in 0...levelByChar.count-1{
            var x = 0
            while x < levelByChar[y].count{
                if levelByChar[y][x] == "#"{
                    var wall = SKSpriteNode(imageNamed: "brick")
                    let xval = Double(x)
                    let yval = Double(levelByChar.count-y-1)
                    wall.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    wall.xScale = 0.5
                    wall.yScale = 0.5
                    walls.append(wall)
                    addChild(wall)
                }else if levelByChar[y][x] == "."{
                    var target = SKSpriteNode(imageNamed: "target")
                    let xval = Double(x)
                    let yval = Double(levelByChar.count-y-1)
                    target.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    target.xScale = 0.5
                    target.yScale = 0.5
                    targets.append(target)
                    addChild(target)
                    var space = SKSpriteNode(imageNamed: "tile")
                    space.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    space.xScale = 0.5
                    space.yScale = 0.5
                    space.zPosition = -1
                    spaces.append(space)
                    addChild(space)
                }else if levelByChar[y][x] == "$"{
                    var box = SKSpriteNode(imageNamed: "box")
                    let xval = Double(x)
                    let yval = Double(levelByChar.count-y-1)
                    box.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    box.xScale = 0.5
                    box.yScale = 0.5
                    boxes.append(box)
                    addChild(box)
                    var space = SKSpriteNode(imageNamed: "tile")
                    space.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    space.xScale = 0.5
                    space.yScale = 0.5
                    space.zPosition = -1
                    spaces.append(space)
                    addChild(space)
                }else if levelByChar[y][x] == "@"{
                    let xval = Double(x)
                    let yval = Double(levelByChar.count-y-1)
                    player.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    player.xScale = 0.5
                    player.yScale = 0.5
                    addChild(player)
                    var space = SKSpriteNode(imageNamed: "tile")
                    space.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    space.xScale = 0.5
                    space.yScale = 0.5
                    space.zPosition = -1
                    spaces.append(space)
                    addChild(space)
                }else if levelByChar[y][x] == "*"{
                    let xval = Double(x)
                    var box = SKSpriteNode(imageNamed: "box")
                    let yval = Double(levelByChar.count-y-1)
                    box.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    box.xScale = 0.5
                    box.yScale = 0.5
                    box.color = UIColor.cyan
                    box.colorBlendFactor = 1
                    box.zPosition = 1
                    boxes.append(box)
                    addChild(box)
                    var target = SKSpriteNode(imageNamed: "target")
                    target.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    target.xScale = 0.5
                    target.yScale = 0.5
                    targets.append(target)
                    addChild(target)
                    var space = SKSpriteNode(imageNamed: "tile")
                    space.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    space.xScale = 0.5
                    space.yScale = 0.5
                    space.zPosition = -1
                    spaces.append(space)
                    addChild(space)
                    //print(x,i)
                }else if levelByChar[y][x] == "+"{
                    var target = SKSpriteNode(imageNamed: "target")
                    let xval = Double(x)
                    let yval = Double(levelByChar.count-y-1)
                    target.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    target.xScale = 0.5
                    target.yScale = 0.5
                    targets.append(target)
                    addChild(target)
                    player.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    player.xScale = 0.5
                    player.yScale = 0.5
                    player.zPosition = 1
                    addChild(player)
                    var space = SKSpriteNode(imageNamed: "tile")
                    space.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    space.xScale = 0.5
                    space.yScale = 0.5
                    space.zPosition = -1
                    spaces.append(space)
                    addChild(space)
                    //print(x,i)
                }else if levelByChar[y][x] == " "{
                    var space = SKSpriteNode(imageNamed: "tile")
                    let xval = Double(x)
                    let yval = Double(levelByChar.count-y-1)
                    space.position = CGPoint(x: (xval*scale)-300, y: (yval*scale)-50)
                    space.xScale = 0.5
                    space.yScale = 0.5
                    space.zPosition = -1
                    spaces.append(space)
                    addChild(space)
                    //print(x,i)
                }
                x += 1
            }
        }
        checkGameState()
    }
    
    func checkGameState(){
        checkArray = []
        for y in 0...levelByChar.count-1{
        if levelByChar[y].contains(Character("$")){
            checkArray += "$"
            gameIsWon = false
            }
        }
        if checkArray.isEmpty{
            gameIsWon = true
            print(gameIsWon)
            let filename = levelSet
            
            if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
                do {
                    
                    let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                    //print(levels)
                    levelArray += levels.components(separatedBy: ";")
                } catch {
                    print("Failed to read text from \(filename)")
                }
            } else {
                print("Failed to load file from app bundle \(filename)")
            }
            var levelNum:Int? = nil
            for i in 0...levelArray.count-1{
                if level == levelArray[i]{
                levelNum = i
                    if levelNum == levelArray.count{
                        levelNum = levelNum!-1
                    }
                }
            }
            
            level = levelArray[(levelNum)!+1]
            
            
            let lx = leftBtn.position.x
            let ly = leftBtn.position.y
            let rx = rightBtn.position.x
            let ry = rightBtn.position.y
            let ux = upBtn.position.x
            let uy = upBtn.position.y
            let dx = downBtn.position.x
            let dy = downBtn.position.y
            let zix = zoomInBtn.position.x
            let ziy = zoomInBtn.position.y
            let zox = zoomOutBtn.position.x
            let zoy = zoomOutBtn.position.y
            let udx = undoBtn.position.x
            let udy = undoBtn.position.y
            let rsx = restartBtn.position.x
            let rsy = restartBtn.position.y
            let lvx = leftvBtn.position.x
            let lvy = leftvBtn.position.y
            let rvx = rightvBtn.position.x
            let rvy = rightvBtn.position.y
            let uvx = upvBtn.position.x
            let uvy = upvBtn.position.y
            let dvx = downvBtn.position.x
            let dvy = downvBtn.position.y
            let sl = leftBtn.xScale
            let rs = restartBtn.xScale
            
            removeChildren(in: boxes)
            removeChildren(in: walls)
            removeChildren(in: spaces)
            removeChildren(in: targets)
            for child in children{
                child.removeFromParent()
            }
            player.removeFromParent()
            levelByChar = []
            moves = []
            boxes = []
            spaces = []
            targets = []
            gameIsWon = false
            checkArray = []
            nameGrab = level.components(separatedBy: .newlines)
            if nameGrab[1] != ""{
                levelName = nameGrab[1]
                levelNumber = nameGrab[0]
            }else{
                levelNumber = nameGrab[0]
            }
            levelByLine = level.components(separatedBy: .newlines)
            let levelNumberArray = levelNumber.components(separatedBy: " ")
            if Int(levelNumberArray[1]) != levelArray.count-1{
                for i in 1...levelByLine.count-4{
                    levelByChar.append(Array(levelByLine[i+1]))
                }
            }else{
                for i in 1...levelByLine.count-3{
                    levelByChar.append(Array(levelByLine[i+1]))
                }
            }
            
            if String(levelByChar[0]) == ""{
                levelByChar.remove(at: 0)
            }
            
            
            leftBtn.position = CGPoint(x: lx, y: ly)
            addChild(leftBtn)
            rightBtn.position = CGPoint(x: rx, y: ry)
            addChild(rightBtn)
            upBtn.position = CGPoint(x: ux, y: uy)
            addChild(upBtn)
            downBtn.position = CGPoint(x: dx, y: dy)
            addChild(downBtn)
            zoomInBtn.position = CGPoint(x: zix, y: ziy)
            addChild(zoomInBtn)
            zoomOutBtn.position = CGPoint(x: zox, y: zoy)
            addChild(zoomOutBtn)
            undoBtn.position = CGPoint(x: udx, y: udy)
            addChild(undoBtn)
            restartBtn.position = CGPoint(x: rsx, y: rsy)
            leftvBtn.position = CGPoint(x: lvx, y: lvy)
            addChild(leftvBtn)
            rightvBtn.position = CGPoint(x: rvx, y: rvy)
            addChild(rightvBtn)
            upvBtn.position = CGPoint(x: uvx, y: uvy)
            addChild(upvBtn)
            downvBtn.position = CGPoint(x: dvx, y: dvy)
            addChild(downvBtn)
            leftvBtn.setScale(sl*cameraScale)
            rightvBtn.setScale(sl*cameraScale)
            upvBtn.setScale(sl*cameraScale)
            downvBtn.setScale(sl*cameraScale)
            leftBtn.setScale(sl*cameraScale)
            rightBtn.setScale(sl*cameraScale)
            upBtn.setScale(sl*cameraScale)
            downBtn.setScale(sl*cameraScale)
            zoomInBtn.setScale(sl*cameraScale)
            zoomOutBtn.setScale(sl*cameraScale)
            undoBtn.setScale(rs*cameraScale)
            restartBtn.setScale(rs*cameraScale)
            addChild(restartBtn)
            print(player.position)
            generateLevel()
        }

    }
    
    func getPlayerPosition() -> [Int] {
        for y in 0...levelByChar.count-1{
            for x in 0...levelByChar[y].count-1{
                if levelByChar[y][x] == Character("@") {
                    playerXY = [x,y]
                }else if levelByChar[y][x] == Character("+") {
                    playerXY = [x,y]
                }
            }
        }
        return playerXY
    }
    
    func getBoxPosition(direction: String, pix: CGFloat, piy: CGFloat) -> Int {
        var bID:Int = 0
        let px = pix
        let py = piy
        print(px)
        print(py)
        if direction == "L" {
        for y in 0...boxes.count-1{
            print("\(y) \(boxes[y].position.x)")
            print("\(y) \(px-CGFloat(scale))")
            print("\(y) \(boxes[y].position.y)")
            print("\(y) \(py)")
            if boxes[y].position.x == px-CGFloat(scale) && boxes[y].position.y == py{
                bID = y
                print("bID: \(bID)")
                break
            }
            
        }
          //  return bID!
        }else if direction == "R"{
            for y in 0...boxes.count-1{
                print("\(y) \(boxes[y].position.x)")
                print("\(y) \(px+CGFloat(scale))")
                print("\(y) \(boxes[y].position.y)")
                print("\(y) \(py)")
                if boxes[y].position.x == px+CGFloat(scale) && boxes[y].position.y == py{
                    bID = y
                    print("bID: \(bID)")
                    break
                }
                
            }
          //  return bID!
        }else if direction == "U"{
            for y in 0...boxes.count-1{
                print("\(y) \(boxes[y].position.y)")
                print("\(y) \(py+CGFloat(scale))")
                print("\(y) \(boxes[y].position.x)")
                print("\(y) \(px)")
                if boxes[y].position.y == py+CGFloat(scale) && boxes[y].position.x == px{
                    bID = y
                    print("bID: \(bID)")
                    break
                }
            }
          //.  return bID!
        }else if direction == "D"{
            for y in 0...boxes.count-1{
                print("\(y) \(boxes[y].position.y)")
                print("\(y) \(py-CGFloat(scale))")
                print("\(y) \(boxes[y].position.x)")
                print("\(y) \(px)")
                if boxes[y].position.y == py-CGFloat(scale) && boxes[y].position.x == px{
                    bID = y
                    print("bID: \(bID)")
                    break
                }
            }
           // return bID!
        }
    print(bID)
       // myGroup.leave()
        return bID

    }
    
    func animateBox(direction: String, pos: Int){
        
        if direction == "L" {
            let bDestination = player.position.x - CGFloat(scale*2)
            let movingBox = SKAction.moveTo(x: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            print("pos: \(pos)")
        }else if direction == "R"{
            let bDestination = player.position.x + CGFloat(scale*2)
            let movingBox = SKAction.moveTo(x: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            print("pos: \(pos)")
        }else if direction == "U"{
            let bDestination = player.position.y + CGFloat(scale*2)
            let movingBox = SKAction.moveTo(y: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            print("pos: \(pos)")
        }else if direction == "D"{
            let bDestination = player.position.y - CGFloat(scale*2)
            let movingBox = SKAction.moveTo(y: bDestination, duration: 0.025)
            boxes[pos].zPosition = 1
            boxes[pos].run(movingBox)
            print("pos: \(pos)")
        }
    }
    
    func animateCharacterl(){
        for y in 0...boxes.count-1{
            if boxes[y].position.x == player.position.x-CGFloat(scale){
            }
        }
        
        player.zPosition = 1
        let pdestinationl = player.position.x - CGFloat(scale)
        let movingActionl = SKAction.moveTo(x: pdestinationl, duration: 0.025)
        player.run(movingActionl)
        print(player.position)
    }
    func animateCharacterr(){
        player.zPosition = 1
        let pdestinationr = player.position.x + CGFloat(scale)
        let movingActionr = SKAction.moveTo(x: pdestinationr, duration: 0.025)
        player.run(movingActionr)
        print(player.position)
    }
    func animateCharacteru(){
        player.zPosition = 1
        let pdestinationu = player.position.y + CGFloat(scale)
        let movingActionu = SKAction.moveTo(y: pdestinationu, duration: 0.025)
        player.run(movingActionu)
        print(player.position)
    }
    func animateCharacterd(){
        player.zPosition = 1
        let pdestinationd = player.position.y - CGFloat(scale)
        let movingActiond = SKAction.moveTo(y: pdestinationd, duration: 0.025)
        player.run(movingActiond)
        print(player.position)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(moves)
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
