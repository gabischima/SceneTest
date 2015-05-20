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
        let moonRotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        moonNode.position = SCNVector3Make(2, 0, 0)
        let repeatedMoonRotate = SCNAction.repeatActionForever(moonRotate)
        moonNode.runAction(repeatedMoonRotate)
        planetNode.addChildNode(moonNode)
        
        let ring = SCNTube(innerRadius: 1.5, outerRadius: 2, height: 0.01)
        ring.firstMaterial!.diffuse.contents = UIColor.brownColor()
        let ringNode = SCNNode(geometry: ring)
        let ringNode2 = SCNNode(geometry: ring)

       // ringNode.position = SCNVector3Make(0, 0, 0)
        var pifloat = Float(M_PI)
        ringNode.transform = SCNMatrix4MakeRotation( pifloat / 3, 0, 1, 1)
        ringNode2.transform = SCNMatrix4MakeRotation( 3*pifloat / 2, 0, 1, 1)
        planetNode.addChildNode(ringNode)
        planetNode.addChildNode(ringNode2)

    }
    
    override init() {
        super.init()
        createSun()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
