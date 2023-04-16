//
//  GameScene.swift
//  Drawing
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var shape = SKShapeNode()
    var pathPoints: [CGPoint] = []
 
  override func didMove(to view: SKView) {

    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    createPath()
    redrawPath()
      
    let buttonEraser = SKShapeNode(circleOfRadius: 100)
    buttonEraser.name = "buttonEraser"
    buttonEraser.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    buttonEraser.zPosition = 6
    addChild(buttonEraser)
  }

  override func update(_ currentTime: TimeInterval) {
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    //pathPoints.removeAll(keepingCapacity: true)
    let location = touch.location(in: self)
    let node = self.atPoint(location)
      if node.name == "buttonEraser"{
            if wayPoints.count == 0 { return }
            wayPoints.removeAll(keepingCapacity: true)
        }
      
      pathPoints.append(location)
      redrawPath()
      shape.alpha = 1
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    let location = touch.location(in: self)
      pathPoints.append(location)
      redrawPath()
      }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
  }

  private func createPath() {
      shape = SKShapeNode()
      shape.zPosition = 2
      shape.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
      shape.lineWidth = 6

    addChild(shape)
  }

  private func redrawPath() {
    if pathPoints.count < 2 {
        shape.path = nil
      return
    }
    let path = UIBezierPath()
    path.move(to: pathPoints[0])

    for i in 1 ..< pathPoints.count { path.addLine(to: pathPoints[i]) }
    shape.path = path.cgPath
  }

}
