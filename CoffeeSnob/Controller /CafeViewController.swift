//import CoreLocation
//import TomTomSDKMapDisplay
//import UIKit
//import TomTomSDKCommon
//import TomTomSDKSearchOnline
//import TomTomSDKSearch
//import SwiftUI
//
//import SwiftUI
//
//struct CafeMapView: UIViewRepresentable {
//    typealias UIViewType = CafeViewController
//
//    func makeUIView(context: Context) -> CafeViewController {
//        return CafeViewController()
//    }
//
//    func updateUIView(_ uiView: CafeViewController, context: Context) {
//        // Update the view if needed
//    }
//}
//
//class CafeViewController: UIViewController, MapViewDelegate {
//    var mapView: TomTomMap!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        initializeMapView()
//    }
//    
//    private func initializeMapView() {
//        let styleContainer = StyleContainer.defaultStyle
//        let cameraUpdate = CameraUpdate(position: CLLocationCoordinate2D(latitude: -37.77, longitude: 175.28), zoom: 10.0, tilt: 45, rotation: 0)
//        let resourceCachePolicy = OnDiskCachePolicy.cache(duration: Measurement.tt.hours(10), maxSize: Measurement.tt.megabytes(200))
//        let mapOptions = MapOptions(mapStyle: styleContainer, apiKey: "Your_API_Key", cameraUpdate: cameraUpdate, cachePolicy: resourceCachePolicy)
//        
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.mapView = MapView(mapOptions: mapOptions)
//            self.mapView.delegate = self
//            self.view.addSubview(self.mapView)
//            self.mapView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
//                self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//                self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//                self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//            ])
//        }
//    }
//
//    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onMapReady map: TomTomSDKMapDisplay.TomTomMap) {
//        print("MapViewDelegate - onMapReady")
//    }
//    
//    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onStyleLoad result: Result<TomTomSDKMapDisplay.StyleContainer, any Error>) {
//        print("MapViewDelegate - onStyleLoad")
//    }
//    
//    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onInteraction interaction: MapInteraction) {
//        switch interaction {
//        case .tapped(coordinate: let coordinate):
//            print("Tapped at coordinate: \(coordinate)")
//            // Handle tapping on the map
//        default:
//            break
//        }
//    }
//}
