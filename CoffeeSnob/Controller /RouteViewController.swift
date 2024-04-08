import CoreLocation
import TomTomSDKMapDisplay
import UIKit
import TomTomSDKCommon
import TomTomSDKSearchOnline
import TomTomSDKSearch
import SwiftUI
import TomTomSDKNavigation

class RouteViewController: UIViewController, MapViewDelegate {
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
        
        // Call the onMapReadyCallback closure if it's set
               if let callback = onMapReadyCallback {
                   callback(map)
               }
        
        addMarkers()
        
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
        let toleranceSquared: Double = 50 * 50 // Tolerance of 100 points
        guard minDistanceSquared <= toleranceSquared, let marker = closestMarker else {
            // Tap is not on a marker or no marker is found within the tolerance
            print("Tap is not on a marker.")
            return
        }
        
        // Select the closest marker using its annotation
        mapView?.map.select(annotation: marker)
        
        // Handle the tap using InteractionManager
        interactionManager.handleTappedOnLocationMarker(coordinate: marker.annotationCoordinate)
    }



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeManager.setupCafes()
        initializeMapView()
        addMarkers()
        map?.zoomToMarkers(marginPx: 1000)
        mapView?.delegate = self
        mapView?.isUserInteractionEnabled = true
        map?.setExclusiveGestures(gesture: .tap, blockedGestures: [.pan, .pinch, .rotate, .tilt, .longPress])
        
        
   
    }
    
    private func initializeMapView() {
        
        let styleContainer = StyleContainer.defaultStyle
        let cameraUpdate = CameraUpdate(position: CLLocationCoordinate2D(latitude: -37.77, longitude: 175.28), zoom: 10.0, tilt: 45, rotation: 0)
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
                    mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
                    mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
                
                
                
            }
        }
        
    }
    
    private func addMarkers() {
        guard let map = map else { return }
        
        let cafes = cafeManager.getCafes()
        // Loop through each cafe of cafes, creating a MarkerOptions object with the cafe's coordinates
        for cafe in  cafes {
            var markerOptions = MarkerOptions(coordinate: cafe.coordinate.toCLLocationCoordinate2D())
            
            markerOptions.scalingFactor = 0.5 //adjust the size of the markers
            
            do {
                let marker = try map.addMarker(options: markerOptions)
                marker.isVisible = true
                marker.isSelectable = true
            } catch {
                print("Failed to add marker: \(error)")
            }
        }
    }
    
    
    
    
}
    
    
    

    

    
  
