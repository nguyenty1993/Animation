//
//  DetailViewController.swift
//  Animation
//
//  Created by Ty Nguyen on 1/11/17.
//  Copyright © 2017 Ty Nguyen. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, NSZoomTransitionAnimating, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var mapView: MKMapView!
    var mapView = MKMapView()
    var locationManager = CLLocationManager()
    var imagefromViewMain = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = imagefromViewMain
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "btn-nav-left")
        }
        
        return annotationView
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = CLLocationCoordinate2D.init(latitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude))
        let region = MKCoordinateRegion.init(center: center, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        //self.locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : " + error.localizedDescription)
    }
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
    func transitionSourceImageView() -> UIImageView {
        return imageView
    }
    
    func transitionSourceBackgroundColor() -> UIColor {
        return view.backgroundColor!
    }
    
    func transitionDestinationImageViewFrame() -> CGRect {
        return imageView.frame
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMapView" {
            let vc = segue.destination as! MapKitViewController
            vc.transitioningDelegate = self
            vc.image = imagefromViewMain
//            let m = mapView
//            vc.mapView = mapView
        }
        
    }
    //MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NSZoomTransitionAnimator()
        animator.sourceVC = source
        animator.destinationVC = presented
        animator.goingForward = true
        return animator
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NSZoomTransitionAnimator()
        animator.sourceVC = dismissed
        animator.destinationVC = self
        animator.goingForward = false
        return animator
    }

}
