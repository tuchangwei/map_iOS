//
//  ViewController.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//
//var latitude: CLLocationDegrees
//var longitude: CLLocationDegrees
import UIKit
import MapKit

class Location: NSObject, MKAnnotation{
    
    var name: String
    var location: CLLocationCoordinate2D
    
    init(name: String, location:CLLocationCoordinate2D) {
        
        self.name = name
        self.location = location
        super.init()
    }
    
    var title:String! {
    
        return name
    }
    
    var coordinate: CLLocationCoordinate2D {
        
        return location
    }
    
}


let ttLocationKey = "location"
let ttUserKey = "user"
let ttLatitudeKey = "latitude"
let ttLongitudeKey = "longitude"
class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation? {
        didSet {
        
            self.showAllLocations()
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViews()
        self.setupMap()
        if let user = PFUser.currentUser()  {
            
            self.navigationController?.setNavigationBarHidden(false, animated: false)

        } else {
            
            
            self.loadLoginView()
            
        }

        
    }
    
    func setupViews() {
        
        let rightBarItem = UIBarButtonItem(title: "Upload", style: .Plain, target: self, action:"uploadLocation")
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        let leftBarItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action:"logout")
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
        if self.locationManager.location != nil {
            
             self.setMapViewRegion(self.locationManager.location)
        }
       
    }
    func setMapViewRegion(location :CLLocation) {
        
        var region = MKCoordinateRegionMake(location.coordinate,MKCoordinateSpanMake(0.05, 0.05))
        self.mapView.region = region
    }
    
    func uploadLocation() {
        
        if self.currentLocation == nil {
            
            let alert = UIAlertView()
            alert.message = "Can't get the user's current location"
            alert.addButtonWithTitle("OK")
            alert.show()
            return
        }
        
        SVProgressHUD.show()
        var location:PFObject = PFObject(className: ttLocationKey)
        location.setObject(PFUser.currentUser(), forKey: ttUserKey)
        location.setObject(self.currentLocation?.coordinate.latitude, forKey: ttLatitudeKey)
        location.setObject(self.currentLocation?.coordinate.longitude, forKey: ttLongitudeKey)
        var locationACL:PFACL  = PFACL(user: PFUser.currentUser())
        locationACL.setPublicReadAccess(true)
        location.ACL = locationACL
        
        location.saveInBackgroundWithBlock { (successed: Bool, error: NSError!) -> Void in
            
            if successed {
                
                SVProgressHUD.showSuccessWithStatus("Upload location successfully")
                self.showAllLocations()
            }
            else
            {
                SVProgressHUD.showErrorWithStatus("Upload location failed")
            }
        }
        
    }
    
    func logout() {
        
        PFUser.logOut()
        self.loadLoginView()
    }
    func loadLoginView() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        var loginVC:LoginViewController = LoginViewController(nibName: "LoginViewController",bundle: nil)
        loginVC.delegate = self;
        self.addChildViewController(loginVC)
        self.view.addSubview(loginVC.view);
        loginVC.didMoveToParentViewController(self)
        
    }
    func showAllLocations() {
        
        //note here: if don't use includeKey method, I can't get the userInfo below.
        let query =  PFQuery(className: ttLocationKey).includeKey(ttUserKey)
        query.findObjectsInBackgroundWithBlock { (locations:[AnyObject]!, error:NSError!) -> Void in
            
            if locations != nil && locations.count > 0 {
            
                for(var i=0; i<locations.count; i++) {
                    
                    let pfObject = locations[i] as PFObject
                    var userInfo:PFUser = pfObject.objectForKey(ttUserKey) as PFUser
                    println(userInfo.username)
                    var location = Location(name: userInfo.objectForKey(ttScreenNameKey) as String, location: CLLocationCoordinate2D(latitude: pfObject.objectForKey(ttLatitudeKey) as CLLocationDegrees, longitude: pfObject.objectForKey(ttLongitudeKey) as CLLocationDegrees))
                    self.mapView.addAnnotation(location)
                    
                }
                
            }
        }
    }
    
    
}

extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate, LoginViewControllerDelegate {
    

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        
        
        println("2")
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if let annotation = annotation as? Location {
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView =  mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                
                dequeuedView.annotation = annotation
                view = dequeuedView
            }
            else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinColor = .Red
            }
        }
        return nil
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if locations != nil && locations.count > 0 {
            
            let location:CLLocation = locations[0] as CLLocation
            self.currentLocation = location
            self.setMapViewRegion(location)
        }
        
        println("1")
    }
    
    func afterlogin() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
