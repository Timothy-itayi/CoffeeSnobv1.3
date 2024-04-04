import CoreLocation
import TomTomSDKMapDisplay
import UIKit
import TomTomSDKCommon
import TomTomSDKSearchOnline
import TomTomSDKSearch
import SwiftUI


class RouteViewController: UIViewController, MapViewDelegate , MapDataSource {
    
    var map: TomTomMap!
    var mapView: MapView?
    
    let onlineSearch = OnlineSearchFactory.create(apiKey: "pI4kmVlG64hsmsxz9fLKoMtXOmLVgaJW")
    let hamilton = CLLocationCoordinate2D(latitude: -37.750951, longitude: 175.208783)
    lazy var cafeInfoArray: [CafeInfo] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeMapView()
        addMarkers()
        map?.dataSource = self
        map?.zoomToMarkers(marginPx: 1000)
        mapView?.delegate = self
        mapView?.isUserInteractionEnabled = true
        
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
    
    struct CafeInfo {
        let name: String
        let annotationID: String
    }
    
 
    
    private func createCafeInfoArray() {
        print("Creating cafeInfoArray...")
        
        var cafeInfoArray = [CafeInfo]()
        
        // Clear existing cafeInfoArray
        print("Removing existing elements from cafeInfoArray..")
        cafeInfoArray.removeAll()
        
        for cafe in cafes {
            let cafeInfo = CafeInfo(name: cafe.name, annotationID: cafe.annotationID)
            cafeInfoArray.append(cafeInfo)
        }
        print("CafeInfoArray created a new array successfully.")
       
    }
    
    //Define a struct to represent a cafe
    struct Cafe {
        let id: String
        let name: String
        let coordinate: CLLocationCoordinate2D
        let annotationID: String
        
        init(id: String, name: String, coordinate: CLLocationCoordinate2D, annotationID: String) {
            self.id = id
            self.name = name
            self.coordinate = coordinate
            self.annotationID = annotationID
        }
    }
    
    // Define cafe locations
    let cafes: [Cafe] = [
        Cafe(id: "0" , name:"The Kirk Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.7835991, longitude: 175.28886647), annotationID: "The Kirk Cafe"),
        Cafe(id: "1" ,name:"Cinnamon", coordinate: CLLocationCoordinate2D(latitude: -37.7487678527832, longitude: 175.24078369140625), annotationID: "Cinnamon"),
        Cafe(id: "2" ,name:"The River Kitchen", coordinate: CLLocationCoordinate2D(latitude: -37.788618, longitude: 175.2840732), annotationID: "The River Kitchen"),
        Cafe(id: "3" ,name:"Cafe Fresca", coordinate: CLLocationCoordinate2D(latitude: -37.8067891, longitude: 175.2708707), annotationID: "Cafe Fresca"),
        Cafe(id: "4" ,name:"The Sugar Bowl Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.776354, longitude: 175.2586546), annotationID: "The Sugar Bowl Cafe"),
        Cafe(id: "5" ,name:"Hamilton Gardens Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.7961, longitude: 175.3088), annotationID: "Hamilton Gardens"),
        Cafe(id: "6" ,name:"Lola Breakfast Bar & Cafe", coordinate: CLLocationCoordinate2D(latitude: -37.7946979, longitude: 175.2471037), annotationID: "Lola's Breakfast"),
        Cafe(id: "7" ,name:"Markyle's Coffee and Food Establishment", coordinate: CLLocationCoordinate2D(latitude: -37.7906427, longitude: 175.2848956), annotationID: "Markly's Establishment")
   
    ]
  
    var cafeAnnotations: [String: TomTomSDKMapDisplay.Annotation] = [:]
   

    private func addMarkers() {
        guard let map = map else { return }
        
        createCafeInfoArray { [weak self] in
            guard let self = self else { return }
            
            // Loop through each cafe of cafes, creating a MarkerOptions object with the cafe's coordinates
            for cafe in self.cafes {
                var markerOptions = MarkerOptions(coordinate: cafe.coordinate)
                markerOptions.scalingFactor = 5 //adjust the size of the markers
                
                do {
                    let marker = try map.addMarker(options: markerOptions)
                    marker.isVisible = true
                    marker.image = UIImage(named: "cafe")
                    marker.tag = cafe.annotationID
                    // Keep track of the corresponding annotation
                    self.cafeAnnotations[cafe.annotationID] = marker
                    
//                    print ("$cafeAnnotations.cafe.annotationID : \(cafe.annotationID)" )
                    
                } catch {
                    print("Failed to add marker: \(error)")
                }
            }
        }
    }

    private func createCafeInfoArray(completion: @escaping () -> Void) {
        print("Creating cafeInfoArray...")
        
        var cafeInfoArray = [CafeInfo]()
        
        // Clear existing cafeInfoArray
        print("Removing existing elements from cafeInfoArray..\(cafeInfoArray.removeAll())")
        cafeInfoArray.removeAll()
      
        for cafe in cafes {
            let cafeInfo = CafeInfo(name: cafe.name, annotationID: cafe.annotationID)
            cafeInfoArray.append(cafeInfo)
        }
        print("CafeInfoArray created a new array successfully.")
      
        self.cafeInfoArray = cafeInfoArray
        
        // Call the completion handler to indicate that cafeInfoArray creation is complete
        completion()
    }

    
    
    
    
    
    
    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onStyleLoad result: Result<TomTomSDKMapDisplay.StyleContainer, any Error>) {
        
    }
    
    func map(_ map: TomTomSDKMapDisplay.TomTomMap, viewForSelected marker: any TomTomSDKMapDisplay.Annotation) -> UIView? {
        
        // Check if the marker is of type Marker
        guard let marker = marker as? TomTomSDKMapDisplay.Marker else {return nil}
        
        
        //Retrieve the cafe name from the marker's tag
        let cafeName = marker.tag ?? "Unknown Cafe"
        print(cafeName)
        // Turn the cafe name into text to be displayed in the balloon
        let cafeNameText = "\(cafeName)"
        // return annotation view
        print("Tapped on marker: \(cafeName)")
        let annotationView =
        UIHostingController(rootView: CustomMarkerBalloonView(cafeCard: (cafeNameText)))
        
        
        return annotationView.view
        
        
        
    }
    
    func mapView(_ mapView: TomTomSDKMapDisplay.MapView, onMapReady map: TomTomSDKMapDisplay.TomTomMap) {
        print("MapViewDelegate - onMapReady")
        // Print a message indicating that the map is ready
        print("TomTomMap: The map is ready for interaction.")
        
        self.map = map
        addMarkers()
        
        // Call the findCafe function for each annotation in cafeAnnotations
        for (_, annotation) in cafeAnnotations {
            if let cafe = findCafe(for: annotation.annotationID) {
//                print("Cafe found for annotation ID \(annotation.annotationID): \(cafe.name)")
            } else {
//                print("Cafe not found for cafeName  \(annotation.annotationID)")
            }
        }
        
        // Call the onInteraction function to simulate interaction
        onInteraction(.interactionStarted)
    }
 
    private func findCafe(for annotationID: String) -> CafeInfo? {
        print("Current cafeInfoArray: \(cafeInfoArray)")
        
        if let cafeInfo = cafeInfoArray.first(where: { $0.annotationID == annotationID }) {
//            print("CafeInfo for comparison: \(cafeInfo)")
            return cafeInfo
        }
        
        if let cafeName = cafeInfoArray.first(where: { $0.annotationID == annotationID })?.name {
//            print("CafeName  not found for Cafe Name: \(cafeName)")
        } else {
//            print("Cafe.annotationID not found for annotation ID: \(annotationID)")
        }
        
        return nil
    }

    
    // FUNCTION TO INTERACT WITH THE MARKERS
    func onInteraction (_ interaction: MapInteraction){
        // Print the TomTomMap object
        print("$TomTomMap: OnInteraction function ")
        switch interaction {
        case .interactionStarted:
            print("Interaction with the map started")
            // Handle interaction started event
        case let .tappedOnAnnotation(annotation, _):
            // Ensure the tapped annotation exists in the cafeAnnotation dictionary
            guard let cafeAnnotation = cafeAnnotations[annotation.annotationID] else {
                print("cafe marker not found for annotation ID: \(annotation.annotationID)")
                return
            }
            // Find the cafe corresponding to the tapped annotation
            if let tappedCafe = findCafe(for: cafeAnnotation.annotationID){
                let cafeName = tappedCafe.name
                print("Tapped on cafe: \(cafeName)")
                
                
                // Present the balloon view for the tapped cafe
                let cafeNameText = "\(cafeName)"
                let annotationView = UIHostingController(rootView: CustomMarkerBalloonView(cafeCard: cafeNameText))
                
                // Find a valid UIViewController to present the UIHostingController
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let viewController = windowScene.windows.first?.rootViewController {
                    viewController.present(annotationView, animated: true, completion: nil)
                }
            } else {
//                print("Cafe not found for annotationID: \(annotation.annotationID)")
            }
            break
        default:
            break
        }
    }
}


