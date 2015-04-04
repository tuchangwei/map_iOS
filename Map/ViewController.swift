//
//  ViewController.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViews()
        self.setupMap()
        if let user = PFUser.currentUser()  {
            
            println(user.username)
            
            
            
        } else {
            
            
            var loginVC:LoginViewController = LoginViewController(nibName: "LoginViewController",bundle: nil)
            self.addChildViewController(loginVC)
            self.view.addSubview(loginVC.view);
            loginVC.didMoveToParentViewController(self)
            
            
        }

        
    }
    
    func setupViews() {
        
        let rightBarItem = UIBarButtonItem(title: "Upload", style: .Plain, target: self, action:"uploadLocation")
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        let leftBarItem = UIBarButtonItem(title: "Setting", style: .Plain, target: self, action:"setting")
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    func setupMap() {
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = Double(1000.0)
        if self.locationManager.respondsToSelector("requestWhenInUseAuthorization") {
            
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
        }
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        //set this, then we can see the user location
        self.setMapViewRegion(self.locationManager.location)
    }
    func setMapViewRegion(location :CLLocation) {
        
        var region = MKCoordinateRegionMake(location.coordinate,MKCoordinateSpanMake(0.05, 0.05))
        self.mapView.region = region
    }
    
    func uploadLocation() {
        
        SVProgressHUD.show()
    }
    
    func setting() {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        
        
        println("2")
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location:CLLocation = locations[0] as CLLocation
        self.currentLocation = location
        self.setMapViewRegion(location)
        println("1")
    }
}
