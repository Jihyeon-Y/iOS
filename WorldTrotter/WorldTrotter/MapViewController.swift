//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 윤지현 on 2021/12/27.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    var location: CLLocationManager!
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        var topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        var leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let switchLabel = UILabel()
        switchLabel.text = NSLocalizedString("Points of Interest", comment: "세부정보")
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchLabel)
        topConstraint = switchLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5)
        leadingConstraint = switchLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true

        let pointsSwitch = UISwitch()
        pointsSwitch.isOn = true
        pointsSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        pointsSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointsSwitch)
        topConstraint = pointsSwitch.centerYAnchor.constraint(equalTo: switchLabel.centerYAnchor)
        leadingConstraint = pointsSwitch.leadingAnchor.constraint(equalTo: switchLabel.trailingAnchor, constant: 5)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        location = CLLocationManager()
        location.requestWhenInUseAuthorization()
        mapView?.showsUserLocation = true
    }
    @objc func mapTypeChanged(_ segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    @objc func switchToggled(_ pointsSwitch: UISwitch) {
        if pointsSwitch.isOn {
            mapView.pointOfInterestFilter = .includingAll
        } else {
            mapView.pointOfInterestFilter = .excludingAll
        }
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
