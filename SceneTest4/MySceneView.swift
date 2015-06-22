//
//  MySceneView.swift
//  SceneTest4
//
//  Created by Gabriela Schirmer Mauricio on 5/13/15.
//  Copyright (c) 2015 Gabriela Schirmer Mauricio. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

let sun = SCNSphere(radius: 3.0)
let sunNode = SCNNode(geometry: sun)

let planet = SCNSphere(radius: 1.0)
let planetNode = SCNNode(geometry: planet)

let ring = SCNPlane(width: 10, height: 10)
let ringNode = SCNNode(geometry: ring)
let ringNode2 = SCNNode(geometry: ring)
var pifloat = Float(M_PI)

class MySceneView: SCNScene {
    
    func createSun() {
        
        sun.firstMaterial!.diffuse.contents = UIImage(named: "texture_sun.png")
        let rotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        let repeatedRotate = SCNAction.repeatActionForever(rotate)
        sunNode.runAction(repeatedRotate)
        
        var textName = "SUN"
        
        var sunText = SCNText(string: textName, extrusionDepth: 2.0)
        var textNode: SCNNode? = self.rootNode.childNodeWithName("textName", recursively: true)
        
//        textNode!.position = SCNVector3Make(sunNode.position.x - 15.0, sunNode.position.y + 5.0, sunNode.position.z)
//        textNode.scale = SCNVector3Make(0.02, 0.02, 0.02)
        
        let targetNode = SCNLookAtConstraint(target: cameraNode2)
        
//        self.rootNode.addChildNode(textNode!)
        
        self.rootNode.addChildNode(sunNode)
    }
    
    func createRing(withSunNode: SCNNode) {
        
        ring.firstMaterial!.diffuse.contents = UIImage(named: "texture_ring.png")
        //        ring.firstMaterial?.diffuse.contents = UIColor.grayColor()
        ring.firstMaterial?.doubleSided = true
        
        var pifloat = Float(M_PI)
        
        ringNode.transform = SCNMatrix4MakeRotation( pifloat, 1, 1, 1)
        ringNode2.transform = SCNMatrix4MakeRotation( 3*pifloat / 2, 1, 1, 1)
        
        withSunNode.addChildNode(ringNode)
        withSunNode.addChildNode(ringNode2)
    }
    
    func createPlanet() {
    
            planet.firstMaterial!.diffuse.contents = UIImage(named: "planet_water_texture.png")
            let planetRotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 0.5)
            planetNode.position = SCNVector3Make(8, 0, 0)
            let repeatedPlanetRotate = SCNAction.repeatActionForever(planetRotate)
            planetNode.runAction(repeatedPlanetRotate)
            sunNode.addChildNode(planetNode)
        
//            let cloud = SCNSphere(radius: 1.2)
//            cloud.firstMaterial!.diffuse.contents = UIImage(named: "cloud_texture.png")
//            let cloudNode = SCNNode(geometry: cloud)
//            let cloudRotate = SCNAction.rotateByX(0, y: 0.5, z: 0, duration: 1.0)
//            cloudNode.position = SCNVector3Make(8, 0, 0)
//            let repeatedCloudRotate = SCNAction.repeatActionForever(cloudRotate)
//            cloudNode.runAction(repeatedCloudRotate)
//            sunNode.addChildNode(cloudNode)
        
//        var labelNode = SKLabelNode(text: "Hello")

//        let titleText = SCNText(string: "My Title", extrusionDepth: 0.3)
//        let titleNode = SCNNode(geometry: titleText)
//        titleNode.position = SCNVector3Make(0, 1.0, 0)
//        titleNode.scale = SCNVector3Make(0.1, 0.1, 0.1)
//        let titleRotation = SCNAction.rotateByX(0, y: -1.0, z: 0, duration: 1.0)
//        let repeatedTextRotate = SCNAction.repeatActionForever(titleRotation)
//        titleNode.runAction(repeatedTextRotate)
//        planetNode.addChildNode(titleNode)
//        
//        let moon = SCNSphere(radius: 0.3)
//        moon.firstMaterial!.diffuse.contents = UIColor.greenColor()
//        let moonNode = SCNNode(geometry: moon)
//        let moonRotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
//        moonNode.position = SCNVector3Make(2, 0, 0)
//        let repeatedMoonRotate = SCNAction.repeatActionForever(moonRotate)
//        moonNode.runAction(repeatedMoonRotate)
//        planetNode.addChildNode(moonNode)
        
//        let ring = SCNTube(innerRadius: 3.5, outerRadius: 5, height: 0.01)
    }
    
    func createbackground(){
        
        let particleSystem = SCNParticleSystem(named: "MyParticleSystem", inDirectory: nil)
        let systemNode = SCNNode()
        systemNode.addParticleSystem(particleSystem)
        self.rootNode.addChildNode(systemNode)
    }
    
    func newSun () {
       
        let sunNode2 = SCNNode(geometry: SCNSphere(radius: 3.0));
        sunNode2.geometry!.firstMaterial?.diffuse.contents = UIImage(named: "texture_sun.png")
        sunNode2.position = SCNVector3Make(-20, 0, 0)
        let rotate2 = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        let repeatedRotate2 = SCNAction.repeatActionForever(rotate2)
        sunNode2.runAction(repeatedRotate2)
        createRing(sunNode2)
        self.rootNode.addChildNode(sunNode2)
        println("<<New Sun Created>>")
    }
    
    func newPlanet () {
        
        let planet2 = SCNSphere(radius: 1.0)
        planet2.firstMaterial!.diffuse.contents = UIImage(named: "planet_water_texture.png")
        let planetNode2 = SCNNode(geometry: planet2)
        let planetRotate2 = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        planetNode2.position = SCNVector3Make(10, 3, 2)
        let repeatedPlanetRotate = SCNAction.repeatActionForever(planetRotate2)
        planetNode2.runAction(repeatedPlanetRotate)
//        sunNode.addChildNode(planetNode2)
        createPlanet()
        println("<<New Planet Created>>")
    }
    
    func newMoon() {
        
        let moon = SCNSphere(radius: 0.3)
        moon.firstMaterial!.diffuse.contents = UIColor.grayColor()
        let moonNode = SCNNode(geometry: moon)
        let moonRotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
        moonNode.position = SCNVector3Make(2, 0, 0)
        let repeatedMoonRotate = SCNAction.repeatActionForever(moonRotate)
        moonNode.runAction(repeatedMoonRotate)
        planetNode.addChildNode(moonNode)
        
        println("<<New Moon Created>>")
    }
    
    func deteleSun (sun: SCNNode) {
        
        sun.removeFromParentNode()
    }
    
    func deletePlanet (planet: SCNNode) {
        
        planet.removeFromParentNode()
    }
    
    func deleteMoon (moon: SCNNode) {
        
        moon.removeFromParentNode()
    }
    
    
    
    override init() {
        super.init()
        createbackground()
        createSun()
        createRing(sunNode)
        createPlanet()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
