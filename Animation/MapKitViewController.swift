//
//  MapKitViewController.swift
//  Animation
//
//  Created by Ty Nguyen on 1/25/17.
//  Copyright © 2017 Ty Nguyen. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate,NSZoomTransitionAnimating, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.navigationItem.hidesBackButton = true
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
    
    func transitionSourceImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.image = image
        return imageView
    }
    
    func transitionSourceBackgroundColor() -> UIColor {
        return view.backgroundColor!
    }
    
    func transitionDestinationImageViewFrame() -> CGRect {
        return mapView.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.transitioningDelegate = self
        vc.imagefromViewMain = image
        
    }
    //MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NSZoomTransitionAnimator()
        animator.sourceVC = source
        animator.destinationVC = presented
        animator.goingForward = true
        return animator
    }
    
    

}
