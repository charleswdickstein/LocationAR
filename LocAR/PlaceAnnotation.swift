//
//  PlaceAnnotation.swift
//  LocAR
//
//  Created by Charles Dickstein on 11/11/17.
//  Copyright © 2017 Charles Dickstein. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import ARCL
import SceneKit


class PlaceAnnotation : LocationNode{
    
    var title:String!
    var annotationNode :SCNNode
    
     init(location: CLLocation?, title: String) {
       

        self.annotationNode = SCNNode()
        self.title = title
        super.init(location: location)
        initializeUI()
        
    }
    
    private func initializeUI(){
        let plane = SCNPlane(width: 5, height: 3)
        plane.firstMaterial?.diffuse.contents = UIColor.red
        
     
        
        let planeNode = SCNNode(geometry: plane)
        let text = SCNText(string: self.title, extrusionDepth: 0)
        text.containerFrame = CGRect(x: 0, y: 0, width: 5, height: 3)
        text.isWrapped = true
        text.font = UIFont(name: "Futura", size: 1.0)
        text.alignmentMode = kCAAlignmentCenter
        text.truncationMode = kCATruncationMiddle
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0,0,0.2)
        planeNode.addChildNode(textNode)
        
        self.annotationNode.scale = SCNVector3(3,3,3)
        self.annotationNode.addChildNode(planeNode)
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
        self.addChildNode(self.annotationNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    
}


