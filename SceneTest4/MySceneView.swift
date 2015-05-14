//
//  MySceneView.swift
//  SceneTest4
//
//  Created by Gabriela Schirmer Mauricio on 5/13/15.
//  Copyright (c) 2015 Gabriela Schirmer Mauricio. All rights reserved.
//

import UIKit
import SceneKit

class MySceneView: SCNScene {
    
//    let rotate: NSArray!

    func createSun(){
        let sun = SCNSphere(radius: 3.0)
        sun.firstMaterial!.diffuse.contents = UIImage(named: "texture_sun.jpg")
        let sunNode = SCNNode(geometry: sun)
        let rotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        let repeatedRotate = SCNAction.repeatActionForever(rotate)
        sunNode.runAction(repeatedRotate)
        self.rootNode.addChildNode(sunNode)
        
        let planet = SCNSphere(radius: 1.0)
        planet.firstMaterial!.diffuse.contents = UIColor.grayColor()
        let planetNode = SCNNode(geometry: planet)
        let planetRotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        planetNode.position = SCNVector3Make(8, 0, 0)
        let repeatedPlanetRotate = SCNAction.repeatActionForever(planetRotate)
        planetNode.runAction(repeatedPlanetRotate)
        sunNode.addChildNode(planetNode)
        
        let titleText = SCNText(string: "My Title", extrusionDepth: 0.3)
        let titleNode = SCNNode(geometry: titleText)
        titleNode.position = SCNVector3Make(0, 1.0, 0)
        titleNode.scale = SCNVector3Make(0.1, 0.1, 0.1)
        let titleRotation = SCNAction.rotateByX(0, y: -1.0, z: 0, duration: 1.0)
        let repeatedTextRotate = SCNAction.repeatActionForever(titleRotation)
        titleNode.runAction(repeatedTextRotate)
        planetNode.addChildNode(titleNode)
        
        let moon = SCNSphere(radius: 0.3)
        moon.firstMaterial!.diffuse.contents = UIColor.greenColor()
        let moonNode = SCNNode(geometry: moon)
        let mooonRotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        moonNode.position = SCNVector3Make(2, 0, 0)
        let repeatedMoonRotate = SCNAction.repeatActionForever(mooonRotate)
        moonNode.runAction(repeatedMoonRotate)
        planetNode.addChildNode(moonNode)
    }
    
    override init() {
        super.init()
        createSun()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
