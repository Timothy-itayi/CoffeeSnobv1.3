
import CoreLocation
import TomTomSDKMapDisplay
import TomTomSDKNavigation
import TomTomSDKNavigationVisualization
import UniformTypeIdentifiers
import UIKit

class MelbourneCafeManager {
   
    static let shared = MelbourneCafeManager()
    
 

    
    
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
     
        
        init(id: String, name: String, address: String, rating: Int, coordinate: LocationCoordinate, openingTime: Date, closingTime: Date, description: String) {
            self.id = id
            self.name = name
            self.address = address
            self.rating = rating
            self.coordinate = coordinate
            self.openingTime = openingTime
            self.closingTime = closingTime
            self.description = description
          
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
        let HigherHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Thursday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Friday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 16, minute: 0)), // Saturday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 16, minute: 0)), // Sunday
        ]
        
        let KineticHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 6, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Monday
            (openingTime: createDate(hour: 6, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 6, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 6, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Thursday
            (openingTime: createDate(hour: 86, minute: 30), closingTime: createDate(hour: 16, minute: 30)), // Friday
            // Saturday and Sunday are closed for Lola
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Saturday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Sunday
         
        ]
        
        let AixHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Thursday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Friday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Saturday
            (openingTime: createDate(hour: 0, minute: 0), closingTime: createDate(hour: 0, minute: 0)), // Sunday
        ]

        let BrickLaneHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 14, minute: 30)), // Monday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 14, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 14, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 14, minute: 30)), // Thursday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 14, minute: 30)), // Friday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Saturday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 14, minute: 30)), // Sunday
        ]
        
        let JournalHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 21, minute: 30)), // Thursday
            // Saturday and Sunday are closed for Lola
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 15, minute: 0)), // Saturday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 14, minute: 0)), // Sunday
        ]
   
        
        let KettleHours: [(openingTime: Date, closingTime: Date)] = [
            // Monday to Friday are closed for River Kitchen
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Thursday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Friday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Saturday
            (openingTime: createDate(hour: 8, minute: 0), closingTime: createDate(hour: 16, minute: 0)), // Sunday
        ]
        
        let ALiHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Monday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Thursday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Friday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Saturday
            (openingTime: createDate(hour: 7, minute: 0), closingTime: createDate(hour: 17, minute: 0)), // Sunday
        ]
        let AuntHours: [(openingTime: Date, closingTime: Date)] = [
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Monday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Tuesday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Wednesday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Thursday
            (openingTime: createDate(hour: 7, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Friday
            (openingTime: createDate(hour: 8, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Saturday
            (openingTime: createDate(hour: 8, minute: 30), closingTime: createDate(hour: 15, minute: 30)), // Sunday
        ]

        // Create cafe instances with the defined opening and closing times
        cafes = [
            Cafe(id: "0", name: "Higher Ground", address: " 650 Little Bourke St, Melbourne VIC 3000, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.8144645690918, longitude: 144.9585418701172), openingTime: HigherHours[0].openingTime, closingTime: HigherHours[0].closingTime, description: "Modern, upscale bites in an industrial-chic former power station with exposed-brick walls."),
            Cafe(id: "1", name: "Cafe Kinetic", address: "103 Flinders Ln, Melbourne VIC 3000, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.81537628173828, longitude: 144.97068786621094), openingTime: KineticHours[0].openingTime, closingTime: KineticHours[0].closingTime, description: "Smart, casual cafe for a buffet of roasts, vegetables and salad, with chandeliers and ample seating"),
            Cafe(id: "2", name: "Aix Cafe", address: "24 Centre Pl, Melbourne VIC 3000, Australia", rating: 3, coordinate: LocationCoordinate(latitude: -37.816699, longitude:144.9656491), openingTime: AixHours[0].openingTime, closingTime: AixHours[0].closingTime, description: "Tiny creperie with warm vibe, offering sweet choices like nutella and mango, or savoury peking duck."),
            Cafe(id: "3", name: "Brick Lane Melbourne", address: " 33 Guildford Ln, Melbourne VIC 3000, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.8114349, longitude: 144.9598528), openingTime: BrickLaneHours[0].openingTime, closingTime: BrickLaneHours[0].closingTime, description: "Menu"),
            Cafe(id: "4", name: "The Journal Cafe", address: "253 Flinders Ln, Melbourne VIC 3000, Australia", rating: 5, coordinate: LocationCoordinate(latitude: -37.817840576171875, longitude: 144.9658660888672), openingTime: JournalHours[0].openingTime, closingTime: JournalHours[0].closingTime, description: "Light meals in a spacious, high-ceilinged cafe with suspended bookshelves and retro furniture."),
            Cafe(id: "5", name: "The Kettle Black", address: "50 Albert Rd, South Melbourne VIC 3205, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.83432388305664, longitude: 144.9714813232422), openingTime: KettleHours[0].openingTime, closingTime: KettleHours[0].closingTime, description: "Modern Australian cafe fare served in a chic terrace house with white walls & modern lighting."),
            Cafe(id: "6", name: "ST. ALi Coffee Roasters", address: "St Ali Coffee Roasters, 12-18 Yarra Place, South Melbourne VIC 3205, Australia", rating: 5, coordinate: LocationCoordinate(latitude: -37.8313313, longitude: 144.9604687), openingTime: ALiHours[0].openingTime, closingTime: ALiHours[0].closingTime, description: "Warm, low-lit cafe in converted warehouse with exposed brick and furniture made from old lift doors."),
            Cafe(id: "7", name: "Aunt Billies Cafe", address: "184 Surrey Rd, Blackburn VIC 3130, Australia", rating: 5, coordinate: LocationCoordinate(latitude:-37.8162727355957, longitude: 145.15655517578125), openingTime: AuntHours[0].openingTime, closingTime: AuntHours[0].closingTime, description: "Warm, low-lit cafe in converted warehouse with exposed brick and furniture made from old lift doors."),
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

        
        func getMelCafes() -> [Cafe] {
            return cafes
        }
      
   
    }
// Extension to conform Cafe to Annotation protocol
extension MelbourneCafeManager.Cafe: Annotation {
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

