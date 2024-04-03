import CoreLocation
import TomTomSDKMapDisplay
import UIKit
import TomTomSDKCommon
import TomTomSDKSearchOnline
import TomTomSDKSearch
import SwiftUI

class RouteViewController: UIViewController, MapViewDelegate, SearchBarViewDelegate {
    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onStyleLoad result: Result<TomTomSDKMapDisplay.StyleContainer, any Error>) {
        
    }
    
        func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onMapReady map: TomTomSDKMapDisplay.TomTomMap) {
        self.map = map
        addMarkers()
    }
    
   
    func didSearchForCafes() {
        
    }
    
    var map: TomTomMap?
    var mapView: MapView?
    var searchBarView: SearchBarView?
    let onlineSearch = OnlineSearchFactory.create(apiKey: "pI4kmVlG64hsmsxz9fLKoMtXOmLVgaJW")
    let hamilton = CLLocationCoordinate2D(latitude: -37.750951, longitude: 175.208783)
    
    //Define a struct to represent a cafe
    struct Cafe {
        let id: String
        let name: String
        let coordinate: CLLocationCoordinate2D
        
        init(id: String, name: String, coordinate: CLLocationCoordinate2D) {
            self.id = id
            self.name = name
            self.coordinate = coordinate
        }
    }
    
    // Define cafe locations
    let cafes: [Cafe] = [
        Cafe(id: "0" , name:"The Kirk Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.7835991, longitude: 175.28886647)),
        Cafe(id: "1" ,name:"Cinnamon", coordinate: CLLocationCoordinate2D(latitude: -37.7487678527832, longitude: 175.24078369140625)),
        Cafe(id: "2" ,name:"The River Kitchen", coordinate: CLLocationCoordinate2D(latitude: -37.788618, longitude: 175.2840732)),
        Cafe(id: "3" ,name:"Cafe Fresca", coordinate: CLLocationCoordinate2D(latitude: -37.8067891, longitude: 175.2708707)),
        Cafe(id: "4" ,name:"The Sugar Bowl Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.776354, longitude: 175.2586546)),
        Cafe(id: "5" ,name:"Hamilton Gardens Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.7961, longitude: 175.3088)),
        Cafe(id: "6" ,name:"Lola Breakfast Bar & Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.7946979, longitude: 175.2471037)),
        Cafe(id: "7" ,name:"Markyle's Coffee and Food Establishment", coordinate: CLLocationCoordinate2D(latitude: -37.7906427, longitude: 175.2848956))
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        initializeMapView()
        addMarkers()
    }
    
    private func setupSearchBar() {
        searchBarView = SearchBarView()
        searchBarView?.delegate = self
        if let searchBarView = searchBarView {
            view.addSubview(searchBarView)
            searchBarView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBarView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
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
                    mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                    mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
                
                mapView.isUserInteractionEnabled = true

            }
        }
    }
    
    private func addMarkers() {
        guard let map = map else { return }
        
        
        for cafe in cafes {
            let markerOptions = MarkerOptions(coordinate: cafe.coordinate)
            do {
                let marker = try map.addMarker(options: markerOptions)
                marker.isSelectable = true
                marker.isVisible = true
                marker.image = UIImage(named: "cafe")
            } catch {
                print("Failed to add marker: \(error)")
            }
            
           

        }
        // Zoom to markers after adding them to the map
        map.zoomToMarkers(marginPx: 20)
        // Implementing balloons
     
    }
    
    func mapView(_ map: TomTomSDKMapDisplay.MapView, didSelect marker: TomTomSDKMapDisplay.Annotation) -> UIView? {
        print("Marker selected")
        // Check if the marker is of type marker
        guard let marker = marker as? TomTomSDKMapDisplay.Marker else { return nil }
        
        
        // Create an instance of CustomMarkerBalloonView
            let balloonView = CustomMarkerBalloonView(locationCoordinates: "Cafe name: \(marker.annotationID)")
            
            // Wrap the view into a UIHostingController
            let hostingController = UIHostingController(rootView: balloonView)
            
            // Return the UIView of the hosting controller
            return hostingController.view
        }
    
    
    
}
        
