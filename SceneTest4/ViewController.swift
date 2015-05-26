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
    var geometryNode = SCNNode()
    
    let cameraNode = SCNNode()
    
    // Gestures
    var currentAngle: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

        setupScene()
        
        let tap = UITapGestureRecognizer(target:self, action: "sceneTap:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        geometryNode.position = SCNVector3Make(0, 30, 0)
        
        scnView.scene!.rootNode.addChildNode(geometryNode)
        
        let buttonGeometry = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0.3)
        buttonGeometry.firstMaterial?.diffuse.contents = UIColor.redColor()
        button = SCNNode(geometry: buttonGeometry)
        button.position = SCNVector3(x: 5, y: 0.5, z: -30)
        scnView.scene?.rootNode.addChildNode(button)
        
        geometryNode.addChildNode(cameraNode)
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
            }
        }
    }
    
    func setupScene(){
        
        scnView = self.view as! SCNView
        
        scnView.scene = MySceneView()

        scnView.backgroundColor = UIColor.blackColor()
        
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.zFar = 200
        cameraNode.camera!.yFov = 50
        cameraNode.camera!.xFov = 50

        cameraNode.position = SCNVector3Make(0, 0, 30)
//        cameraNode.rotation  = SCNVector4Make(1.0, 0.0, 0.0, Float(-M_PI_4*0.75))
        
        scnView.pointOfView = cameraNode
        
        scnView.autoenablesDefaultLighting = true
        
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        scnView.addGestureRecognizer(panRecognizer)
        
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var angleX = (Float)(translation.x)*(Float)(M_PI)/180.0
        var angleZ = (Float)(translation.x)*(Float)(M_PI_2)/180.0

        angleX += currentAngle
        
        geometryNode.transform = SCNMatrix4MakeRotation(angleX, 0, 1, 0)
//        cameraNode.transform = SCNMatrix4MakeTranslation(angleX*10, 0, 0)
        
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = angleX
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
    
    // MARK: Transition
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        scnView.stop(nil)
        scnView.play(nil)
    }
}

