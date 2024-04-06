
import CoreLocation
import TomTomSDKMapDisplay
import TomTomSDKNavigation
import TomTomSDKNavigationVisualization

class CafeManager {
    static let shared = CafeManager()
    
 

    
    
    struct LocationCoordinate: Equatable {
        let latitude: CLLocationDegrees
        let longitude: CLLocationDegrees

        init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            self.latitude = latitude
            self.longitude = longitude
        }

        static func ==(lhs: LocationCoordinate, rhs: LocationCoordinate) -> Bool {
            return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
        }
        
        func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
                   return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
               }
    }

    //Define a struct to represent a cafe
    struct Cafe {
        let id: String
        let name: String
        let coordinate: LocationCoordinate
        
        init(id: String, name: String, coordinate: LocationCoordinate) {
            self.id = id
            self.name = name
            self.coordinate = coordinate
            
        }
    }
        private var cafes: [Cafe] = []
        private init() {}
        
       func setupCafes(){
            cafes = [
                Cafe(id: "0" , name:"The Kirk Cafe", coordinate: LocationCoordinate(latitude: -37.7835991, longitude: 175.28886647)),
                Cafe(id: "1" ,name:"Cinnamon", coordinate: LocationCoordinate(latitude: -37.7487678527832, longitude: 175.24078369140625)),
                Cafe(id: "2" ,name:"The River Kitchen", coordinate: LocationCoordinate(latitude: -37.788618, longitude: 175.2840732)),
                Cafe(id: "3" ,name:"Cafe Fresca", coordinate: LocationCoordinate(latitude: -37.8067891, longitude: 175.2708707)),
                Cafe(id: "4" ,name:"The Sugar Bowl Cafe", coordinate: LocationCoordinate(latitude: -37.776354, longitude: 175.2586546)),
                Cafe(id: "5" ,name:"Hamilton Gardens Cafe", coordinate: LocationCoordinate(latitude: -37.7961, longitude: 175.3088)),
                Cafe(id: "6" ,name:"Lola Breakfast Bar & Cafe", coordinate: LocationCoordinate(latitude: -37.7946979, longitude: 175.2471037)),
                Cafe(id: "7" ,name:"Markyle's Coffee and Food Establishment", coordinate: LocationCoordinate(latitude: -37.7906427, longitude: 175.2848956)),
                
            ]
            
        }
        
        func getCafes() -> [Cafe] {
            return cafes
        }
      
   
    }
// Extension to conform Cafe to Annotation protocol
extension CafeManager.Cafe: Annotation {
    var annotationID: String {
        return id
    }
    
    var tag: String? {
        get { return nil }
        set { }
    }
    
    var isSelectable: Bool {
        get { return true }
        set { }
    }
    
    var annotationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}
