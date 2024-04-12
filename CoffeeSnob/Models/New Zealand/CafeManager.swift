
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
        let openingHours: [(Date, Date)]
        let description: String
        let images:[UIImage]
        
        init(id: String, name: String, address: String, rating: Int, coordinate: LocationCoordinate, openingHours: [(Date, Date)], description: String, images: [UIImage]) {
            self.id = id
            self.name = name
            self.address = address
            self.rating = rating
            self.coordinate = coordinate
            self.openingHours = openingHours
            self.description = description
            self.images = images
        }
        
        
        func isOpen() -> Bool {
            let now = Date()
            let weekday = Calendar.current.component(.weekday, from: now)
            
            // Adjust for zero-based array index
            guard weekday - 1 < openingHours.count else {
                return false
            }
            
            let currentDayOpeningHours = openingHours[weekday - 1]
            
            let openingTime = currentDayOpeningHours.0
            let closingTime = currentDayOpeningHours.1
            
            // Check if the cafe is closed for the entire day
            if openingTime == closingTime {
                return false
            }
         
            
            let adjustedClosingTime = Calendar.current.date(byAdding: .minute, value: -1, to: closingTime)!
            return now >= openingTime && now <= adjustedClosingTime
        }

      }
   
        private var cafes: [Cafe] = []
        private init() {}
    func setupCafes() {
        // Define the opening and closing times for each cafe
        let frescaHours: [[( Date, Date)]] = [
            [( createDate(hour: 7, minute: 0),  createDate(hour: 16, minute: 0))], // Monday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Tuesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Wednesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Thursday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 16, minute: 0))], // Friday
            [(createDate(hour: 8, minute: 0), createDate(hour: 16, minute: 0))], // Saturday
            [( createDate(hour: 8, minute: 0), createDate(hour: 16, minute: 0))], // Sunday
        ]
        
        let kirkHours: [[( Date, Date)]] = [
            [(createDate(hour: 8, minute: 0),  createDate(hour: 14, minute: 30))], // Monday
            [( createDate(hour: 8, minute: 0),  createDate(hour: 14, minute: 30))], // Tuesday
            [(createDate(hour: 8, minute: 0), createDate(hour: 14, minute: 30))], // Wednesday
            [( createDate(hour: 8, minute: 0),  createDate(hour: 14, minute: 30))], // Thursday
            [(createDate(hour: 8, minute: 30),  createDate(hour: 14, minute: 30))], // Friday
            [( createDate(hour: 9, minute: 0),  createDate(hour: 14, minute: 30))], // Saturday
            [(createDate(hour: 9, minute: 0),  createDate(hour: 14, minute: 30))], // Sunday
        ]
        
        let gardensHours:[[( Date, Date)]] = [
            [( createDate(hour: 9, minute: 0),  createDate(hour: 17, minute: 0))], // Monday
            [( createDate(hour: 9, minute: 0),  createDate(hour: 17, minute: 0))], // Tuesday
            [( createDate(hour: 9, minute: 0),  createDate(hour: 17, minute: 0))], // Wednesday
            [( createDate(hour: 9, minute: 0), createDate(hour: 17, minute: 0))], // Thursday
            [( createDate(hour: 9, minute: 0),  createDate(hour: 17, minute: 0))], // Friday
            [( createDate(hour: 9, minute: 0),createDate(hour: 17, minute: 0))], // Saturday
            [( createDate(hour: 9, minute: 0), createDate(hour: 17, minute: 0))], // Sunday
        ]

        let markylesHours: [[( Date, Date)]] = [
            [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 0))], // Monday
            [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 0))], // Tuesday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 0))], // Wednesday
            [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 0))], // Thursday
            [( createDate(hour: 8, minute: 0),createDate(hour: 13, minute: 30))], // Friday
            [( createDate(hour: 8, minute: 0),createDate(hour: 13, minute: 30))], // Saturday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 0))], // Sunday
        ]
        
        let lolaHours:[ [( Date, Date)]] = [
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 30))], // Monday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 30))], // Tuesday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 30))], // Wednesday
            [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 30))], // Thursday
            // Saturday and Sunday are closed for Lola
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Saturday
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Sunday
        ]
        
        let sugarBowlHours: [[( Date, Date)]] = [
            [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 30))], // Monday
            [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 30))], // Tuesday
           [( createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 30))], // Wednesday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 30))], // Thursday
            [( createDate(hour: 8, minute: 0), createDate(hour: 15, minute: 0))], // Friday
            [( createDate(hour: 8, minute: 0),  createDate(hour: 15, minute: 0))], // Saturday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 14, minute: 30))], // Sunday
        ]
        
        let riverKitchenHours: [[( Date, Date)]] = [
            // Monday to Friday are closed for River Kitchen
            [(createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Monday
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Tuesday
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Wednesday
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Thursday
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Friday
            [( createDate(hour: 9, minute: 0),  createDate(hour: 14, minute: 0))], // Saturday
            [( createDate(hour: 9, minute: 0),  createDate(hour: 14, minute: 0))], // Sunday
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
            Cafe(id: "0", name: "The Kirk Cafe", address: "6 Te Aroha Street, Hamilton East, Hamilton 3216", rating: 4, coordinate: LocationCoordinate(latitude: -37.7835991, longitude: 175.28886647), openingHours: kirkHours.flatMap {$0},  description: "Wonderful place", images: [kirkImage,kirkImage2,kirkImage3,kirkImage4]),
            Cafe(id: "1", name: "Cafe Fresca", address: "78 Alison Street, Hamilton Lake, Hamilton 3210", rating: 4, coordinate: LocationCoordinate(latitude: -37.8067891, longitude: 175.2708707), openingHours: frescaHours.flatMap {$0}, description: "Example 5", images: [frescaImage2, frescaImage, frescaImage3,frescaImage4]),
            Cafe(id: "2", name: "Hamilton Gardens Cafe", address: "Hamilton Gardens, Hamilton East, Hamilton 3216", rating: 3, coordinate: LocationCoordinate(latitude: -37.7961, longitude: 175.3088), openingHours: gardensHours.flatMap {$0}, description: "Description", images:[ gardenImage,gardenImage2, gardenImage3, gardenImage4]),
            Cafe(id: "3", name: "Markyle's Coffee and Food Establishment", address: "38B Hood Street, Hamilton Central, Hamilton 3204", rating: 4, coordinate: LocationCoordinate(latitude: -37.7906427, longitude: 175.2848956), openingHours: markylesHours.flatMap {$0}, description: "Menu", images: [markyleImage, markyleImage2, markyleImage3,markyleImage4]),
            Cafe(id: "4", name: "Lola Breakfast Bar & Cafe", address: "2 Whatawhata Road, Dinsdale, Hamilton 3204", rating: 5, coordinate: LocationCoordinate(latitude: -37.7946979, longitude: 175.2471037), openingHours: lolaHours.flatMap {$0}, description: "Polar", images: [lolaImage, lolaImage2]),
            Cafe(id: "5", name: "The Sugar Bowl Cafe", address: "150 Maeroa Road, Maeroa, Hamilton 3200", rating: 4, coordinate: LocationCoordinate(latitude: -37.776354, longitude: 175.2586546), openingHours: sugarBowlHours.flatMap {$0}, description: "Example 56", images: [sugarBowlImage, sugarBowlImage2, sugarBowlImage3, sugarBowlImage4]),
            Cafe(id: "6", name: "The River Kitchen", address: "217 Victoria Street, Hamilton Central, Hamilton 3204", rating: 5, coordinate: LocationCoordinate(latitude: -37.788618, longitude: 175.2840732), openingHours: riverKitchenHours.flatMap {$0}, description: "Example 4", images: [riverKitchenImage2, riverKitchenImage3, riverKitchenImage, riverKitchenImage4]),
        ]
    }

    // Helper function to create a Date object with the specified hour and minute
    func createDate(hour: Int, minute: Int) -> Date {
        let now = Date() // Get the current date and time
          let calendar = Calendar.current
          var components = calendar.dateComponents([.year, .month, .day], from: now)
          components.hour = hour
          components.minute = minute
      
        // Set the time zone to Melbourne's time zone (Australian Eastern Standard Time)
        let timeZone = TimeZone(identifier: "Pacific/Auckland")!
        components.timeZone = timeZone
        // Assuming today's date for simplicity, you may set other date components as needed
        return Calendar.current.date(from: components)!
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
