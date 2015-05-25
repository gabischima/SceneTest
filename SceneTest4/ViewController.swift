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
    
    var currentAngle: Float = 0.0
    
    var geometryNode: SCNNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scnView = self.view as! SCNView
        
        scnView.scene = MySceneView();
        scnView.backgroundColor = UIColor.blackColor()
//
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3(x: 0, y: -5, z: 10)
//        scnView.scene?.rootNode.addChildNode(cameraNode)
        
//        var image = UIImage(named: "universo.png")
//        var foto = image?.CGImage

        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true
        
        //botao
//        let buttonGeometry = SCNBox(width: 2.5, height: 2, length: 1, chamferRadius: 0.3)//SCNSphere(radius: 1)
//        buttonGeometry.firstMaterial?.diffuse.contents = UIImage(named: "mais2.jpg")
//        button = SCNNode(geometry: buttonGeometry)
//        button.position = SCNVector3(x: 1.5, y: -15, z: 0)
//        scnView.scene?.rootNode.addChildNode(button)
        
        //tap para o botao
//        let tap = UITapGestureRecognizer(target:self, action: "sceneTap:")
//        tap.numberOfTapsRequired = 1
//        tap.numberOfTouchesRequired = 1
//        scnView.gestureRecognizers = [tap]
        
        
        //tap para mexer no fundo
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        scnView.addGestureRecognizer(panRecognizer)
        geometryNode = scnView.scene!.rootNode
//
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/90.0
        newAngle += currentAngle
        
        //diz qual eixo vai girar
        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 1, 1, 1)
        
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
        }
    }

    
    func sceneTap(recognizer: UITapGestureRecognizer) {

        let location = recognizer.locationInView(scnView)
        let hitResults = scnView.hitTest(location, options: nil)
        if hitResults?.count > 0 {
            
            let result = hitResults![0] as! SCNHitTestResult
            
            let node = result.node
            
            //checa se o node é o node do botao e executa a acao
            if node == button {
                println("oi")
                (scnView.scene as! MySceneView).newSun() //metodo da mysceneview
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

