
import CoreLocation
import TomTomSDKMapDisplay
import TomTomSDKNavigation
import TomTomSDKNavigationVisualization
import UniformTypeIdentifiers
import UIKit
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

    // Define a struct to represent a cafe
    struct Cafe {
        let id: String
        let name: String
        let address: String
        let rating: Int
        let coordinate: LocationCoordinate
        let openingTime: Date
        let closingTime: Date
        let description: String
        let images:[UIImage]
        
        init(id: String, name: String, address: String, rating: Int, coordinate: LocationCoordinate, openingTime: Date, closingTime: Date, description: String, images: [UIImage]) {
            self.id = id
            self.name = name
            self.address = address
            self.rating = rating
            self.coordinate = coordinate
            self.openingTime = openingTime
            self.closingTime = closingTime
            self.description = description
            self.images = images
        }
        
        func isOpen() -> Bool {
              let now = Date()
              // Check if the current time falls within any of the cafe's operating hours
              return  now >= openingTime && now <= closingTime
          }
      }
   
        private var cafes: [Cafe] = []
        private init() {}
    func setupCafes() {
        // Define the opening and closing times for each cafe
        let frescaHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Thursday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Friday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Saturday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Sunday
        ]
        
        let kirkHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Monday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Thursday
            (openingTime: createDate(hour: 8, minute: 30), closingTime: createDate(hour: 14, minute: 30)), // Friday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Saturday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Sunday
        ]
        
        let gardensHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Monday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Thursday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Friday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Saturday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Sunday
        ]

        let markylesHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Thursday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 13, minute: 30)), // Friday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 13, minute: 30)), // Saturday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Sunday
        ]
        
        let lolaHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Thursday
            // Saturday and Sunday are closed for Lola
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Saturday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Sunday
        ]
        
        let sugarBowlHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Thursday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 15, minute: 0)), // Friday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 15, minute: 0)), // Saturday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Sunday
        ]
        
        let riverKitchenHours: [(openingTime: Date, closingTime: Date)] = [
            // Monday to Friday are closed for River Kitchen
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Monday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Thursday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Friday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Saturday
            (openingTime: createDate(hour: 9, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Sunday
        ]
        
      guard let kirkImage = UIImage(named: "cafekirk1"),
            let kirkImage2 = UIImage(named: "cafekirk2"),
            let kirkImage3 = UIImage(named: "cafekirk3"),
            let kirkImage4 = UIImage(named: "cafekirk4"),
            let frescaImage = UIImage(named: "cafefresca1"),
            let frescaImage2 = UIImage(named: "cafefresca2"),
            let frescaImage3 = UIImage(named: "cafefresca3"),
            let frescaImage4 = UIImage(named: "cafefresca4"),
            let gardenImage = UIImage(named: "gardens1"),
            let gardenImage2 = UIImage(named: "gardens2"),
            let gardenImage3 = UIImage(named: "gardens3"),
            let gardenImage4 = UIImage(named: "gardens4"),
            let lolaImage = UIImage(named: "lola1"),
            let lolaImage2 = UIImage(named: "lola2"),
            let markyleImage = UIImage(named: "markyle1"),
            let markyleImage2 = UIImage(named: "markyle2"),
            let markyleImage3 = UIImage(named: "markyle3"),
            let markyleImage4 = UIImage(named: "markyle4"),
            let sugarBowlImage = UIImage(named: "sugar1"),
            let sugarBowlImage2 = UIImage(named: "sugar2"),
            let sugarBowlImage3 = UIImage(named: "sugar3"),
            let sugarBowlImage4 = UIImage(named: "sugar4"),
            let riverKitchenImage = UIImage(named: "riverkitchen1"),
            let riverKitchenImage2 = UIImage(named: "riverkitchen2"),
            let riverKitchenImage3 = UIImage(named: "riverkitchen3"),
            let riverKitchenImage4 = UIImage(named: "riverkitchen4")
       else {
          print("One or more images not found")
          return
      }
        

        // Create cafe instances with the defined opening and closing times
        cafes = [
            Cafe(id: "0", name: "The Kirk Cafe", address: "6 Te Aroha Street, Hamilton East, Hamilton 3216", rating: 4, coordinate: LocationCoordinate(latitude: -37.7835991, longitude: 175.28886647), openingTime: kirkHours[0].openingTime, closingTime: kirkHours[0].closingTime, description: "Wonderful place", images: [kirkImage,kirkImage2,kirkImage3,kirkImage4]),
            Cafe(id: "1", name: "Cafe Fresca", address: "78 Alison Street, Hamilton Lake, Hamilton 3210", rating: 4, coordinate: LocationCoordinate(latitude: -37.8067891, longitude: 175.2708707), openingTime: frescaHours[0].openingTime, closingTime: frescaHours[0].closingTime, description: "Example 5", images: [frescaImage2, frescaImage, frescaImage3,frescaImage4]),
            Cafe(id: "2", name: "Hamilton Gardens Cafe", address: "Hamilton Gardens, Hamilton East, Hamilton 3216", rating: 3, coordinate: LocationCoordinate(latitude: -37.7961, longitude: 175.3088), openingTime: gardensHours[0].openingTime, closingTime: gardensHours[0].closingTime, description: "Description", images:[ gardenImage,gardenImage2, gardenImage3, gardenImage4]),
            Cafe(id: "3", name: "Markyle's Coffee and Food Establishment", address: "38B Hood Street, Hamilton Central, Hamilton 3204", rating: 4, coordinate: LocationCoordinate(latitude: -37.7906427, longitude: 175.2848956), openingTime: markylesHours[0].openingTime, closingTime: markylesHours[0].closingTime, description: "Menu", images: [markyleImage, markyleImage2, markyleImage3,markyleImage4]),
            Cafe(id: "4", name: "Lola Breakfast Bar & Cafe", address: "2 Whatawhata Road, Dinsdale, Hamilton 3204", rating: 5, coordinate: LocationCoordinate(latitude: -37.7946979, longitude: 175.2471037), openingTime: lolaHours[0].openingTime, closingTime: lolaHours[0].closingTime, description: "Polar", images: [lolaImage, lolaImage2]),
            Cafe(id: "5", name: "The Sugar Bowl Cafe", address: "150 Maeroa Road, Maeroa, Hamilton 3200", rating: 4, coordinate: LocationCoordinate(latitude: -37.776354, longitude: 175.2586546), openingTime: sugarBowlHours[0].openingTime, closingTime: sugarBowlHours[0].closingTime, description: "Example 56", images: [sugarBowlImage, sugarBowlImage2, sugarBowlImage3, sugarBowlImage4]),
            Cafe(id: "6", name: "The River Kitchen", address: "217 Victoria Street, Hamilton Central, Hamilton 3204", rating: 5, coordinate: LocationCoordinate(latitude: -37.788618, longitude: 175.2840732), openingTime: riverKitchenHours[0].openingTime, closingTime: riverKitchenHours[0].closingTime, description: "Example 4", images: [riverKitchenImage2, riverKitchenImage3, riverKitchenImage, riverKitchenImage4]),
        ]
    }

    // Helper function to create a Date object with the specified hour and minute
    func createDate(hour: Int, minute: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        // Assuming today's date for simplicity, you may set other date components as needed
        return Calendar.current.date(from: dateComponents)!
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
