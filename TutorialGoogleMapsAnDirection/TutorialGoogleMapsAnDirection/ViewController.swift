//
//  ViewController.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var detailDirection: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
    var travelMode = TravelModes.driving
    let directionService = DirectionService()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        self.detailDirection.isHidden = true
    }
    
    fileprivate func direction() {
        self.mapView.clear()
        let origin: String = "\(originLatitude),\(originLongtitude)"
        let destination: String =
        "\(destinationLatitude),\(destinationLongtitude)"
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongtitude))
        marker.map = self.mapView
        self.directionService.getDirections(origin: origin,
            destination: destination,
            travelMode: travelMode) { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    self?.drawRoute()
                    if let totalDistance = self?.directionService.totalDistance,
                        let totalDuration = self?.directionService.totalDuration {
                        self?.detailDirection.text = totalDistance + ". " + totalDuration
                        self?.detailDirection.isHidden = false
                    }
                }
            } else {
                print("error direction")
            }
        }
    }

    fileprivate func drawRoute() {
        for step in self.directionService.selectSteps {
            if step.polyline.points != "" {
                let path = GMSPath(fromEncodedPath: step.polyline.points)
                let routePolyline = GMSPolyline(path: path)
                routePolyline.strokeColor = UIColor.red
                routePolyline.strokeWidth = 3.0
                routePolyline.map = mapView
            } else {
                return
            }
        }
    }
    
    @IBAction func walking(_ sender: Any) {
        self.travelMode = TravelModes.walking
        self.direction()
        self.afterDirection()
    }

    @IBAction func bicycling(_ sender: Any) {
        self.travelMode = TravelModes.bicycling
        self.direction()
        self.afterDirection()
    }
    
    @IBAction func driving(_ sender: Any) {
        self.travelMode = TravelModes.driving
        self.direction()
        self.afterDirection()
    }
    
    @IBAction func transit(_ sender: Any) {
        self.travelMode = TravelModes.transit
        self.direction()
        self.afterDirection()
    }
    
    fileprivate func afterDirection() {
        self.directionService.totalDistanceInMeters = 0
        self.directionService.totalDurationInSeconds = 0
        self.directionService.selectLegs.removeAll()
        self.directionService.selectSteps.removeAll()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    //Handle incoming location events.
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location: CLLocation = locations.last {
            let locationLatitude = location.coordinate.latitude
            let locationLongtitude = location.coordinate.longitude
            self.originLatitude = locationLatitude
            self.originLongtitude = locationLongtitude
            let camera = GMSCameraPosition.camera(
                withLatitude: locationLatitude,
                longitude: locationLongtitude, zoom: zoomLevel)
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.destinationLatitude = coordinate.latitude
        self.destinationLongtitude = coordinate.longitude
        let marker = GMSMarker(position: coordinate)
        marker.map = self.mapView
    }
}
