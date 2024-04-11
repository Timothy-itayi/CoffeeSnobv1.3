import CoreLocation
import TomTomSDKMapDisplay
import UIKit
import TomTomSDKCommon
import SwiftUI
import TomTomSDKNavigation
import TomTomSDKLocationProvider


class RouteViewController: UIViewController, MapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onStyleLoad result: Result<TomTomSDKMapDisplay.StyleContainer, any Error>) {
        
    }
    
    
    
    var map: TomTomMap!
    var mapView: MapView?
    let cafeManager = CafeManager.shared
    let interactionManager = InteractionManager.shared
    let hamilton = CLLocationCoordinate2D(latitude: -37.750951, longitude: 175.208783)
    var onMapReadyCallback: ((TomTomMap) -> ())?
    
    
    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onMapReady map: TomTomSDKMapDisplay.TomTomMap) {
        
        print("MapViewDelegate - onMapReady")
        
        // Print a message indicating that the map is ready
        print("TomTomMap: The map is ready for interaction.")
        
        self.map = map
        print("Calling addMarkers function...")
        addMarkers(map: map)

        // Check if the
        let isCurrentLocationButtonVisible = mapView.isCurrentLocationButtonVisible
        print("Is current location button visible? \(isCurrentLocationButtonVisible)")
        
        
        // Add tap gesture recognizer directly to the mapView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.state == .ended else {
            return // Ignore other states
        }
        
        // Get the tap point
        let tapPoint = gestureRecognizer.location(in: mapView)
        
        // Find the marker closest to the tap point
        var closestMarker: CafeManager.Cafe? = nil
        var minDistanceSquared: Double = Double.infinity
        
        for cafeMarker in cafeManager.getCafes() {
            let markerPoint = mapView?.map.pointForCoordinate(coordinate: cafeMarker.annotationCoordinate) ?? .zero
            let distanceSquared = pow(Double(tapPoint.x - markerPoint.x), 2) + pow(Double(tapPoint.y - markerPoint.y), 2)
            if distanceSquared < minDistanceSquared {
                minDistanceSquared = distanceSquared
                closestMarker = cafeMarker
            }
        }
        
        // Check if a marker was found within a certain tolerance
        let toleranceSquared: Double = 15 * 15 // Tolerance of 100 points
        guard minDistanceSquared <= toleranceSquared, let marker = closestMarker else {
            // Tap is not on a marker or no marker is found within the tolerance
            print("Tap is not on a marker.")
            mapView?.map.isMarkersFadingEnabled = false
            return
        }
        
        // Select the closest marker using its annotation
        mapView?.map.isMarkersFadingEnabled = true
        mapView?.map.select(annotation: marker)
        
        // Handle the tap using InteractionManager
        interactionManager.handleTappedOnLocationMarker(coordinate: marker.annotationCoordinate)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeManager.setupCafes()
        initializeMapView()
        
        map?.zoomToMarkers(marginPx: 1000)
        mapView?.delegate = self
        mapView?.isUserInteractionEnabled = true
        map?.setExclusiveGestures(gesture: .tap, blockedGestures: [.pan, .pinch, .rotate, .tilt, .longPress])
        mapView?.isLogoVisible = false
        
        
        
    }
    
    
    
    
    private func initializeMapView() {
        
        let styleContainer = StyleContainer.defaultStyle
        let cameraUpdate = CameraUpdate(position: CLLocationCoordinate2D(latitude: -37.77, longitude: 175.28), zoom: 11, tilt: 45, rotation: 0)
        let resourceCachePolicy = OnDiskCachePolicy.cache(duration: Measurement.tt.hours(10), maxSize: Measurement.tt.megabytes(200))
        let mapOptions = MapOptions(mapStyle: styleContainer, apiKey: "pI4kmVlG64hsmsxz9fLKoMtXOmLVgaJW", cameraUpdate: cameraUpdate, cachePolicy: resourceCachePolicy)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mapView = MapView(mapOptions: mapOptions)
            if let mapView = self.mapView {
                mapView.delegate = self
                self.view.addSubview(mapView)
                
                mapView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 30)
                ])
                
                
            
           
                mapView.isLogoVisible = false
                
                
                print("MapView instance: \(mapView)")
                
                self.map = mapView.map
                
                print("Map instance after setting: \(String(describing: self.map))")
                // Add markers if map instance is not nil
                if let map = self.map {
                    self.addMarkers(map:map)
                }
            } else {
                // Print error if mapView is nil
                print("MapView is nil.")
            }
        }
        
    }
    
    private func addMarkers(map: TomTomMap) {
        print("Adding markers...")
        
        let cafes = cafeManager.getCafes()
        
        if cafes.isEmpty {
               print("No cafes found.")
               return
           }
        // Loop through each cafe of cafes, creating a MarkerOptions object with the cafe's coordinates
        for cafe in cafes {
            print("Cafe Coordinate: \(cafe.coordinate)")
            var markerOptions = MarkerOptions(coordinate: cafe.coordinate.toCLLocationCoordinate2D())
            markerOptions.scalingFactor = 0.5 // Adjust the size of the markers
            
            do {
                let marker = try map.addMarker(options: markerOptions)
                marker.isVisible = true
                marker.isSelectable = true
                print("Marker added at \(cafe.coordinate), visible: \(marker.isVisible)")
            } catch {
                print("Failed to add marker for cafe \(cafe.annotationID): \(error)")
            }
        }
    }

}
    

    
    
    

    

    
  
