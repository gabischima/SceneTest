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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView = self.view as! SCNView
        
        scnView.scene = MySceneView()
        
        scnView.backgroundColor = UIColor.blackColor()
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true
        
        
        let tap = UITapGestureRecognizer(target:self, action: "sceneTap:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        scnView.gestureRecognizers = [tap]
        
        
        
        let buttonGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let buttonMaterial = SCNMaterial()
        buttonMaterial.diffuse.contents = UIColor.redColor()
        buttonGeometry.materials = [buttonMaterial]
        button = SCNNode(geometry: buttonGeometry)
        button.position = SCNVector3(x: 5, y: 0.5, z: 15)
        scnView.scene?.rootNode.addChildNode(button)

    
    }
    
    func sceneTap(recognizer: UITapGestureRecognizer) {
        
        let location = recognizer.locationInView(scnView)
        
        let hitResults = scnView.hitTest(location, options: nil)
        
        
        if hitResults?.count > 0 {
            
            let result = hitResults![0] as! SCNHitTestResult
            let node = result.node
            if node == button {
                //                SCNTransaction.begin()
                //                SCNTransaction.setAnimationDuration(0.5)
                //                let materials = node.geometry?.materials as! [SCNMaterial]
                //                let material = materials[0]
                //                material.diffuse.contents = UIColor.whiteColor()
                //                SCNTransaction.commit()
                //
                //                let action = SCNAction.moveByX(0, y: -0.8, z: 0, duration: 0.5)
                //                node.runAction(action)
                println("oi")
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

