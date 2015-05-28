//
//  ViewController.swift
//  SceneTest4
//
//  Created by Gabriela Schirmer Mauricio on 5/13/15.
//  Copyright (c) 2015 Gabriela Schirmer Mauricio. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    var button : SCNNode!
    var scnView: SCNView!
    var clickcount = 0
    var selectedNode: SCNNode!
    var nodeRadius: CGFloat!
    
    // Geometry
    var geometryNode = SCNNode()
    var geometryNode2 = SCNNode()
    
    let cameraNode = SCNNode()
    let cameraNode2 = SCNNode()

    // Gestures
    var currentAngle: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.locationInView(scnView)
        
        if let hitResults = scnView.hitTest(p, options: nil) {
            
            if hitResults.count > 0 && hitResults[0].node!.geometry! .isKindOfClass(SCNSphere) {
                
                let result: AnyObject! = hitResults[0]
                
                selectedNode = result.node
                
                nodeRadius = (result.node!.geometry! as! SCNSphere).radius
                
                let material = result.node!.geometry!.firstMaterial!
                
                self.cameraPosition2(self.selectedNode)
                
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(1.0)
                
                println("ZOOM IN")
                
                    scnView.pointOfView = self.cameraNode2
                
                SCNTransaction.commit()
            }
            else {
                
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(1.0)
                
                println("ZOOM OUT")
                
                self.cameraPosition()
                scnView.pointOfView = self.cameraNode
                
                SCNTransaction.commit()
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

