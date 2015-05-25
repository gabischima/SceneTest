//
//  Container1ViewController.swift
//  SceneTest4
//
//  Created by Mayara Souza on 5/25/15.
//  Copyright (c) 2015 Gabriela Schirmer Mauricio. All rights reserved.
//

import SceneKit

class Container1ViewController: UIViewController {
    
    var buton:UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
  
        buton = UIButton()
        buton.backgroundColor = UIColor.redColor()
        buton.frame = CGRectMake(180, 500, 50, 50)
        
        buton.addTarget(self, action: Selector("criaPlaneta:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buton)
        
        
        
        // Do any additional setup after loading the view.
    }

    func criaPlaneta(sender : UIButton!)
    {
        println("asas");
        ((self.parentViewController as! ViewController).scnView.scene as! MySceneView).newSun();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
