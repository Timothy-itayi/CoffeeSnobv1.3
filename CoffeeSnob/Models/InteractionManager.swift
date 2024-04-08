import UIKit
import CoreLocation
import TomTomSDKMapDisplay
import TomTomSDKNavigation


protocol MapInteractionDelegate: AnyObject {
    func map(_ map: TomTomMap, onInteraction interaction: MapInteraction)
}
class InteractionManager {
    static let shared = InteractionManager()
    
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
    
    let cafeManager = CafeManager.shared
    
    
    func map(_ map: TomTomMap, onInteraction interaction: MapInteraction) {
        
        switch interaction {
        case .interactionStarted:
            handleInteractionStarted()
   
            
        case let .tapped(coordinate):
            /* Handle tapped on map */
            handleTapped(coordinate: coordinate)
            print("tapped on coordinate")
            
        case let .tappedOnAnnotation(annotation, _):
            /* Handle tapped on annotation */
            if let cafeAnnotation = annotation as? CafeManager.Cafe {
                // If the annotation is a cafe, you can access its properties
                print("Tapped on cafe: \(cafeAnnotation.name)")
                
                // Perform any additional actions, such as displaying information or navigating
                // For example, you can display an alert with the cafe's name
                let alert = UIAlertController(title: cafeAnnotation.name, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Get the top-most view controller to present the alert
                if let topViewController = topMostViewController() {
                    topViewController.present(alert, animated: true, completion: nil)
                }
            } else {
                // Handle other types of annotations, if needed
                print("Tapped on annotation: \(annotation)")
            }
            
        case let .tappedOnLocationMarker(coordinate):
            /* Handle tapped on location marker */
            
            handleTappedOnLocationMarker(coordinate: coordinate)
            
            break
        case .tappedOnRecenterButton:
            /* Handle tapped on recenter button */
            break
        case  .doubleTapped(_):
            /* Handle double tapped */
            break
        case  .tappedWithTwoFingers(_):
            /* Handle tapped with two fingers */
            break
        case .longPressed(_):
            /* Handle long pressed */
            break
        case  .panned(_):
            /* Handle panned */
            break
        case  .pinched(_):
            /* Handle pinched */
            break
        case  .rotated(_):
            /* Handle rotated */
            break
        case  .tilted(_):
            /* Handle tilted */
            break
        @unknown default:
            fatalError()
            
        }
    }
        func topMostViewController() -> UIViewController? {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return nil
            }
            
            var topController = window.rootViewController
            while let presentedViewController = topController?.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
    
 
    func handleTappedOnLocationMarker(coordinate: CLLocationCoordinate2D) {
        /* Handle tapped on location marker */
        let cafes = cafeManager.getCafes()
        
        // Print the number of cafes and the tapped coordinate
    
      
        
        // Define a tolerance value for coordinate comparison
        let tolerance: CLLocationDistance = 0.01 // 10 meters tolerance
        
        // Convert tapped coordinate to CLLocation
        let tappedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        // Find the cafe corresponding to the tapped coordinate
        for cafe in cafes {
            let cafeLocation = CLLocation(latitude: cafe.coordinate.latitude, longitude: cafe.coordinate.longitude)
            
            // Calculate distance between the tapped location and cafe location
            let distance = tappedLocation.distance(from: cafeLocation)
         
            if distance <= tolerance {
                // Instantiate and present the cafe card view controller
                let cafeCardViewController = CafeViewController(cafe: cafe, cafeManager: cafeManager)
                
                // Get the current window
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let viewController = windowScene.windows.first?.rootViewController {
                    viewController.present(cafeCardViewController, animated: true, completion: nil)
                }
                
                // Print the name of the tapped cafe
                print("Tapped on cafe: \(cafe.name)")
                
                return // Exit the function after presenting the cafe card
            }
        }
    


        
        
        // If no cafe corresponds to the tapped coordinate within the tolerance, log a message
        print("No cafe found within \(tolerance) meters of the tapped location")
    }


        func handleInteractionStarted() {
            // Handle interaction started
            print("@Interaction started")
        }
        
        func handleTapped(coordinate: CLLocationCoordinate2D) {
            print("Tapped on coordinate: \(coordinate)")
        }
        
    }


