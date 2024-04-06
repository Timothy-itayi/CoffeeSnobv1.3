import UIKit
import TomTomSDKNavigation
import TomTomSDKMapDisplay
import TomTomSDKNavigationVisualization

class InteractionViewController: UIViewController, MapDelegate{
    func map(_ map: TomTomSDKMapDisplay.TomTomMap, onCameraEvent event: TomTomSDKMapDisplay.CameraEvent) {
        
    }
    
    
    let cafeManager = CafeManager.shared
    let interactionManager = InteractionManager.shared
    
    
    func map(_ map: TomTomMap, onInteraction interaction: MapInteraction) {
        
       
        print("TomTomMap : interaction ")
        interactionManager.map(map, onInteraction: interaction)
        
        switch interaction {
        case let .tapped(coordinate):
            let cafes = cafeManager.getCafes()
            guard let tappedCafe = cafes.first(where: { $0.coordinate == CafeManager.LocationCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude) }) else {
                print("No cafe found at tapped location")
                return
            }
            print("Tapped on cafe: \(tappedCafe.name)")
            
            // Display an alert with the cafe's name
            let alert = UIAlertController(title: "Cafe Details", message: tappedCafe.name, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Get the top-most view controller to present the alert
            if let topViewController = InteractionManager.shared.topMostViewController() {
                topViewController.present(alert, animated: true, completion: nil)
            }

            if let firstCafeCoordinate = cafeManager.getCafes().first?.coordinate {
                
                let coordinate = firstCafeCoordinate.toCLLocationCoordinate2D()
                interactionManager.handleTappedOnLocationMarker(coordinate: coordinate)
            }
            
        default:
            break
        }
    }

    
    
    
    
}



