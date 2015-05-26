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
    
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    
    let cameraNode = SCNNode()

    
    // Gestures
    var currentAngle: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        
        let tap = UITapGestureRecognizer(target:self, action: "sceneTap:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        scnView.gestureRecognizers = [tap]
        
        let buttonGeometry = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0.3)
        buttonGeometry.firstMaterial?.diffuse.contents = UIColor.redColor()
        button = SCNNode(geometry: buttonGeometry)
        button.position = SCNVector3(x: 5, y: 0.5, z: -30)
        scnView.scene?.rootNode.addChildNode(button)
        geometryNode = button
    }
    
    func sceneTap(recognizer: UITapGestureRecognizer) {
        
        let location = recognizer.locationInView(scnView)
        
        let hitResults = scnView.hitTest(location, options: nil)
        
        if hitResults?.count > 0 {
            
            let result = hitResults![0] as! SCNHitTestResult
            let node = result.node
            if node == button {
                let materials = node.geometry?.materials as! [SCNMaterial]
                let material = materials[0]
                
                if clickcount == 0 {
                    SCNTransaction.begin()
                    SCNTransaction.setAnimationDuration(0.5)
                    material.diffuse.contents = UIColor.whiteColor()
                    SCNTransaction.commit()
                    clickcount++
                }
                else {
                    SCNTransaction.begin()
                    SCNTransaction.setAnimationDuration(0.5)
                    material.diffuse.contents = UIColor.redColor()
                    SCNTransaction.commit()
                    clickcount = 0
                }
                
                
                //                let action = SCNAction.moveByX(0, y: -0.8, z: 0, duration: 0.5)
                //                node.runAction(action)
                //                println("oi")
            }
            
            
        }
    }
    
    func setupScene(){
        
        scnView = self.view as! SCNView
        
        scnView.scene = MySceneView()
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        scnView.addGestureRecognizer(panRecognizer)
        scnView.backgroundColor = UIColor.blackColor()
        
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.zFar = 200
        cameraNode.camera!.yFov = 50
        cameraNode.camera!.xFov = 50
        
        cameraNode.position = SCNVector3Make(0, 30, 50);
        cameraNode.rotation  = SCNVector4Make(1.0, 0.0, 0.0, Float(-M_PI_4*0.75));
        
        scnView.pointOfView = cameraNode
        
        scnView.scene!.rootNode.addChildNode(cameraNode)
        
        
        scnView.autoenablesDefaultLighting = true
        
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngle += currentAngle
        
        button.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
            println(currentAngle)
        }
    }
    
    
    //    func checkIfFirstTime(){
    //        // não é primeiro launch
    //        if firstLaunch  {
    //            println("Not first launch.")
    //            blackScreen.hidden = true
    //        }
    //        // é primeiro launch
    //        else {
    //            println("First launch, setting NSUserDefault.")
    //            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
    //            blackScreen.hidden = false
    //        }
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

