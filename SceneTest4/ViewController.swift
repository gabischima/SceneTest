//
//  ViewController.swift
//  SceneTest4
//
//  Created by Gabriela Schirmer Mauricio on 5/13/15.
//  Copyright (c) 2015 Gabriela Schirmer Mauricio. All rights reserved.
//

import UIKit
import SceneKit

let newplanet = SCNSphere(radius: 3.0)
let newPlanetNode = SCNNode(geometry: newplanet)
let rotate = SCNAction.rotateByX(0, y: 1.0, z: 0, duration: 1.0)
let repeatedRotate = SCNAction.repeatActionForever(rotate)

let cameraNode = SCNNode()
let cameraNode2 = SCNNode()

class ViewController: UIViewController {
    
    var button : SCNNode!
    var scnView: SCNView!
    var clickcount = 0
    var selectedNode: SCNNode!
    var nodeRadius: CGFloat!
    
    // Geometry
    var geometryNode = SCNNode()
    var geometryNode2 = SCNNode()



    // Gestures
    var currentAngle: Float = 0.0
    
    // Nodes

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        newplanet.firstMaterial!.diffuse.contents = UIImage(named: "planet_water_texture.png")
        newPlanetNode.runAction(repeatedRotate)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        setupScene()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "sceneTap:")
        var gestureRecognizers = [AnyObject]()
        gestureRecognizers.append(tapGesture)
        if let existingGestureRecognizers = scnView.gestureRecognizers {
            gestureRecognizers.extend(existingGestureRecognizers)
        }
        
        scnView.gestureRecognizers = gestureRecognizers
        
        let buttonGeometry = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0.3)
        buttonGeometry.firstMaterial?.diffuse.contents = UIColor.redColor()
        button = SCNNode(geometry: buttonGeometry)
        button.position = SCNVector3(x: 5, y: 0.5, z: -30)
        scnView.scene?.rootNode.addChildNode(button)
    }
    
    func sceneTap(gestureRecognize: UIGestureRecognizer) {
        
        println("Been here")
        
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.locationInView(scnView)
        
        // If you hit the sun.
        
        if let hitResults = scnView.hitTest(p, options: nil) {
            
            if hitResults.count > 0 && hitResults[0].node!.isEqual(sunNode) {
                
                let result: AnyObject! = hitResults[0]
                
                selectedNode = result.node
                
                nodeRadius = (result.node!.geometry! as! SCNSphere).radius
                
                let material = result.node!.geometry!.firstMaterial!
                
                self.cameraPosition2(self.selectedNode)
                
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(1.0)
                
                println("ZOOM IN")
                
                scnView.pointOfView = cameraNode2
                
                SCNTransaction.commit()
            }
                
            // If you hit the box:
                
            else if hitResults.count > 0 && hitResults[0].node!.geometry!.isKindOfClass(SCNBox) && scnView.pointOfView == cameraNode2 {
                
                if sunNode.parentNode != nil {
                    
                    SCNTransaction.begin()
                    SCNTransaction.setAnimationDuration(1.0)
                    
                    self.cameraPosition()
                    scnView.pointOfView = cameraNode
                    
                    SCNTransaction.commit()
                }
                
                // First Animation: newPlanet fades out.
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(1.0)
                
//                if sun.firstMaterial?.diffuse.contents.name != "texture_sun.png" {
//                    
//                    sun.firstMaterial!.diffuse.contents = UIImage(named: "texture_sun.png")
//                    planet.firstMaterial?.diffuse.contents = UIImage(named: "planet_water_texture.png")
//                    sunNode.addChildNode(ringNode)
//                    sunNode.addChildNode(ringNode2)
//                }
                
                self.cameraPosition()
                scnView.pointOfView = cameraNode
                println("ZOOM OUT")
                
                newPlanetNode.opacity = 0.0
                
                // Second Animation: recreates a hidden sun.
                SCNTransaction.setCompletionBlock {
                    SCNTransaction.begin()
                    SCNTransaction.setAnimationDuration(1.0)
                    
                    newPlanetNode.removeFromParentNode()
                    
                    sunNode.opacity = 0.0
                    scnView.scene?.rootNode.addChildNode(sunNode)
                    
                    // Third Animation: sun fades in.
                    SCNTransaction.setCompletionBlock {
                        SCNTransaction.begin()
                        SCNTransaction.setAnimationDuration(1.0)
                        
                        sunNode.opacity = 1.0
                        
                        SCNTransaction.commit()
                    }
                    
                    SCNTransaction.commit()
                }
                
                SCNTransaction.commit()
            }
                
            // If you hit the planet and your camera is 2:
                
            else if hitResults.count > 0 && (hitResults[0].node!.isEqual(planetNode) || hitResults[0].node!.isEqual(newPlanetNode)) && scnView.pointOfView == cameraNode2 {
                
//                planetNode.removeFromParentNode()
//                scnView.scene?.rootNode.addChildNode(planetNode)
                
                //First Animation: Sun fades out.
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(1.0)
                
                sunNode.opacity = 0.0
                
                // Second Animation: Creates a hidden newPlanet.
                SCNTransaction.setCompletionBlock {
                    SCNTransaction.begin()
                    SCNTransaction.setAnimationDuration(1.0)
                    
                    sunNode.removeFromParentNode()
                    newPlanetNode.opacity = 0.0
                    scnView.scene?.rootNode.addChildNode(newPlanetNode)
                    
                    // Third Animation: newPlanet fades in.
                    SCNTransaction.setCompletionBlock {
                        SCNTransaction.begin()
                        SCNTransaction.setAnimationDuration(1.0)
                        
                        newPlanetNode.opacity = 1.0
                     
                        SCNTransaction.commit()
                    }
                    
                    SCNTransaction.commit()
                }

                SCNTransaction.commit()

//                self.cameraPosition2(self.selectedNode)
                
//                ringNode.removeFromParentNode()
//                ringNode2.removeFromParentNode()
//                sun.firstMaterial!.diffuse.contents = UIImage(named: "planet_water_texture.png")
//                planet.firstMaterial?.diffuse.contents = UIColor.grayColor()
//                println(planet.firstMaterial?.diffuse.contents.description)
                
//                sun.firstMaterial?.diffuse.contents = UIImage(named: "planet_water_texture.png")
//                sunNode.opacity = 1.0

            }
            else if (hitResults.count > 0 && hitResults[0].node!.isEqual(planetNode) && planet.firstMaterial?.diffuse.contents.isEqual(UIColor.grayColor()) != nil) {
                
                println("It's Gray!")
            }
        }
    }
    
    func setupScene(){
        
        scnView = self.view as! SCNView
        
        scnView.scene = MySceneView()

        scnView.backgroundColor = UIColor.blackColor()
        
        cameraNode.camera = SCNCamera()
        cameraNode2.camera = SCNCamera()
        

        cameraPosition()
//        cameraPosition2()
        
        scnView.pointOfView = cameraNode
        
        
        scnView.autoenablesDefaultLighting = true
        
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        scnView.addGestureRecognizer(panRecognizer)
        
    }
    
    func cameraPosition(){
        geometryNode.position = SCNVector3Make(0, 50, 0)
        cameraNode.camera!.zFar = 200
        cameraNode.position = SCNVector3Make(0, 0, 50)
        cameraNode.rotation  = SCNVector4Make(1.0, 0.0, 0.0, Float(-M_PI_4*0.75))
        cameraNode.camera!.yFov = 50
        cameraNode.camera!.xFov = 50
        geometryNode.addChildNode(cameraNode)
        scnView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    func cameraPosition2(selectedNode: SCNNode){
        geometryNode2.position = selectedNode.position
        let targetNode = SCNLookAtConstraint(target: selectedNode)
        targetNode.gimbalLockEnabled = true
        cameraNode2.constraints = [targetNode]
        cameraNode2.camera!.zFar = 200
        cameraNode2.position = SCNVector3Make(selectedNode.position.x, selectedNode.position.y + (4.0*Float(nodeRadius)), (selectedNode.position.z) + (7.0*Float(nodeRadius)))
        cameraNode2.rotation  = SCNVector4Make(1.0, 0.0, 0.0, Float(-M_PI_4*0.75))
        cameraNode2.camera!.yFov = 50
        cameraNode2.camera!.xFov = 50
        geometryNode2.addChildNode(cameraNode2)
        scnView.scene?.rootNode.addChildNode(geometryNode2)
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var angle = (Float)(translation.x)*(Float)(M_PI)/180.0
        angle += currentAngle
        geometryNode.transform = SCNMatrix4MakeRotation(angle, 0, 1, 0)
        geometryNode2.transform = SCNMatrix4MakeRotation(angle, 0, 1, 0)
        cameraPosition()
        
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = angle
            cameraPosition()
            
            println(currentAngle)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Transition
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        scnView.stop(nil)
        scnView.play(nil)
    }
}

