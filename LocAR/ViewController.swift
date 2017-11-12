//
//  ViewController.swift
//  LocAR
//
//  Created by Charles Dickstein on 11/11/17.
//  Copyright © 2017 Charles Dickstein. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ARCL

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var place: String!;
    
    lazy private var locationManager = CLLocationManager()
    
    //allows a view where we can add annotations
    var sceneLocationView = SceneLocationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneLocationView.run()
        self.view.addSubview(sceneLocationView)
        
        self.title = self.place
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        print(self.locationManager.location?.coordinate)
        findLocalPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = self.view.bounds
    }
    
    private func findLocalPlaces(){
        
        guard let location = self.locationManager.location else{return}
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        request.region = region
        
        
        let search = MKLocalSearch(request: request)
        
        search.start{
            response, error in
            if error != nil{
                return
            }
            
            guard let response = response else {return}
            
            for item in response.mapItems{
                print(item.placemark)
                let placeLocation = (item.placemark.location)!
                
                //let image = UIImage(named: "blackpin")
                
                
                
                
              //  let annotationNode = LocationAnnotationNode(location: placeLocation, image: image!)
                
                let placeAnnotationNode = PlaceAnnotation(location: placeLocation, title: item.placemark.name!)
                
                
                DispatchQueue.main.async{
                    
                   self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: placeAnnotationNode)
                }
                print("place location \(placeLocation)")
            }
        
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


