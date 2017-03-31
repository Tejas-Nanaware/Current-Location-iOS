//
//  ViewController.swift
//  Find Me
//
//  Created by admin on 31/03/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let lat = userLocation.coordinate.latitude
        let lon = userLocation.coordinate.longitude
        let latDelta : CLLocationDegrees = 0.005
        let lonDelta : CLLocationDegrees = 0.005
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        latitude.text = String(lat)
        longitude.text = String(lon)
        altitude.text = String(userLocation.altitude)
        speed.text = String(userLocation.speed) + " mph"
        course.text = String(userLocation.course)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) {
            (placemarks, errors) in
            if errors != nil {
                print(errors)
            }
            else {
                if let placemark = placemarks?[0] {
                    var addr = ""
                    if placemark.subThoroughfare != nil {
                        addr += placemark.subThoroughfare! + ", "
                    }
                    if placemark.thoroughfare != nil {
                        addr += placemark.thoroughfare! + ", "
                    }
                    if placemark.subLocality != nil {
                        addr += placemark.subLocality! + ", "
                    }
                    if placemark.locality != nil {
                        addr += placemark.locality! + ", "
                    }
                    if placemark.subAdministrativeArea != nil {
                        addr += placemark.subAdministrativeArea! + ", "
                    }
                    if placemark.administrativeArea != nil {
                        addr += placemark.administrativeArea! + ", "
                    }
                    if placemark.postalCode != nil {
                        addr += placemark.postalCode! + ", "
                    }
                    if placemark.isoCountryCode != nil {
                        addr += placemark.isoCountryCode! + "."
                    }
                    print(addr)
                    self.address.text = addr
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

