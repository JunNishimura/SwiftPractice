//
//  ViewController.swift
//  ARapp
//
//  Created by 西村純 on 2018/04/29.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var audioPlayer = AVAudioPlayer()
    var node: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene

        
        // set the sounds
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bubble", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch {
                
            }
        }
        catch {
            print(error)
        }
    }
    
    // interaction function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        audioPlayer.play()
        guard let touch = touches.first else { return }
        let result = sceneView.hitTest(touch.location(in: sceneView), types: ARHitTestResult.ResultType.featurePoint)
        guard let pointResult = result.last else { return }
        let pointTransform = SCNMatrix4(pointResult.worldTransform)
        let pointVector = SCNVector3Make(pointTransform.m41, pointTransform.m42, pointTransform.m43)
        makeObject(position: pointVector)
        
    }
    
    // make objects here
    func makeObject(position: SCNVector3) {
        let colors = [UIColor.darkGray, UIColor.red, UIColor.blue, UIColor.green, UIColor.cyan]
        let objects = [SCNSphere(radius: 0.2), SCNCone(topRadius: 0.0, bottomRadius: 0.5, height: 0.5), SCNTorus(ringRadius: 0.5, pipeRadius: 0.1)]
        let object = objects[Int(arc4random_uniform(UInt32(objects.count)))]
        object.firstMaterial?.diffuse.contents = colors[ Int(arc4random_uniform(UInt32(colors.count)))]
        node = SCNNode(geometry: object)
        node!.position = position
        
        sceneView.scene.rootNode.addChildNode(node!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
