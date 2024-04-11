
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
        let openingHours: [(Date, Date)]
        let description: String
        let images: [UIImage]
        
        init(id: String, name: String, address: String, rating: Int, coordinate: LocationCoordinate,openingHours: [(Date, Date)], description: String, images:[UIImage]) {
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
        let HigherHours: [[( Date,Date)]] = [
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Monday
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Tuesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Wednesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Thursday
            [(createDate(hour: 7, minute: 0),  createDate(hour: 17, minute: 0))], // Friday
            [(createDate(hour: 7, minute: 30),  createDate(hour: 16, minute: 0))], // Saturday
            [ (createDate(hour: 7, minute: 30), createDate(hour: 16, minute: 0))], // Sunday
        ]
        
        let KineticHours: [[( Date, Date)]] = [
            [(createDate(hour: 6, minute: 0), createDate(hour: 16, minute: 30))], // Monday
            [(createDate(hour: 6, minute: 0),  createDate(hour: 16, minute: 30))], // Tuesday
            [(createDate(hour: 6, minute: 0), createDate(hour: 16, minute: 30))], // Wednesday
            [(createDate(hour: 6, minute: 0),  createDate(hour: 16, minute: 30))], // Thursday
            [(createDate(hour: 6, minute: 30),  createDate(hour: 16, minute: 30))], // Friday
            // Saturday and Sunday are closed for Lola
            [(createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Saturday
            [(createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Sunday
            
        ]
        
        let AixHours: [[( Date, Date)]] = [
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Monday
            [(createDate(hour: 7, minute: 0),  createDate(hour: 16, minute: 0))], // Tuesday
            [(createDate(hour: 7, minute: 0),  createDate(hour: 16, minute: 0))], // Wednesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Thursday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Friday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Saturday
            [( createDate(hour: 0, minute: 0),  createDate(hour: 0, minute: 0))], // Sunday
        ]
        
        let BrickLaneHours: [[( Date, Date)]] = [
            [(createDate(hour: 7, minute: 30),  createDate(hour: 14, minute: 30))], // Monday
            [(createDate(hour: 7, minute: 30), createDate(hour: 14, minute: 30))], // Tuesday
            [(createDate(hour: 7, minute: 30), createDate(hour: 14, minute: 30))], // Wednesday
            [(createDate(hour: 7, minute: 30), createDate(hour: 14, minute: 30))], // Thursday
            [(createDate(hour: 7, minute: 30),createDate(hour: 14, minute: 30))], // Friday
            [(createDate(hour: 8, minute: 0), createDate(hour: 14, minute: 30))], // Saturday
            [(createDate(hour: 8, minute: 0), createDate(hour: 14, minute: 30))], // Sunday
        ]
        
        let JournalHours: [[( Date,  Date)]] = [
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 30))], // Monday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 30))], // Tuesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 30))], // Wednesday
            [(createDate(hour: 7, minute: 0),  createDate(hour: 21, minute: 30))],
            // Saturday and Sunday are closed for Lola
            [(createDate(hour: 8, minute: 0), createDate(hour: 15, minute: 0))], // Saturday
            [(createDate(hour: 7, minute: 0), createDate(hour: 14, minute: 0))], // Sunday
        ]
        
        
        let KettleHours: [[( Date, Date)]] = [
            // Monday to Friday are closed for River Kitchen
            [(createDate(hour: 7, minute: 0),  createDate(hour: 16, minute: 0))], // Monday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Tuesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Wednesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Thursday
            [(createDate(hour: 7, minute: 0), createDate(hour: 16, minute: 0))], // Friday
            [(createDate(hour: 8, minute: 0),  createDate(hour: 16, minute: 0))], // Saturday
            [(createDate(hour: 8, minute: 0),createDate(hour: 16, minute: 0))], // Sunday
        ]
        
        let ALiHours: [[( Date,Date)]] = [
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Monday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 17, minute: 0))], // Tuesday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 17, minute: 0))], // Wednesday
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Thursday
            [(createDate(hour: 7, minute: 0), createDate(hour: 17, minute: 0))], // Friday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 17, minute: 0))], // Saturday
            [( createDate(hour: 7, minute: 0),  createDate(hour: 17, minute: 0))], // Sunday
        ]
        let AuntHours: [[( Date,Date)]] = [
            [(createDate(hour: 7, minute: 30), createDate(hour: 15, minute: 30))], // Monday
            [(createDate(hour: 7, minute: 30), createDate(hour: 15, minute: 30))], // Tuesday
            [(createDate(hour: 7, minute: 30), createDate(hour: 15, minute: 30))], // Wednesday
            [(createDate(hour: 7, minute: 30), createDate(hour: 15, minute: 30))], // Thursday
            [(createDate(hour: 7, minute: 30), createDate(hour: 15, minute: 30))], // Friday
            [(createDate(hour: 8, minute: 30), createDate(hour: 15, minute: 30))], // Saturday
            [(createDate(hour: 8, minute: 30), createDate(hour: 15, minute: 30))], // Sunday
        ]
        
        guard let higherImage = UIImage(named: "higher1"),
              let higherImage2 = UIImage(named: "higher2"),
              let higherImage3 = UIImage(named: "higher3"),
              let higherImage4 = UIImage(named: "higher4"),
              let kineticImage = UIImage(named: "kinetic1"),
              let kineticImage2 = UIImage(named: "kinetic2"),
              let kineticImage3 = UIImage(named: "kinetic3"),
              let kineticImage4 = UIImage(named: "kinetic4"),
              let bricklaneImage = UIImage(named: "bricklane1"),
              let bricklaneImage2 = UIImage(named: "bricklane2"),
              let bricklaneImage3 = UIImage(named: "bricklane3"),
              let bricklaneImage4 = UIImage(named: "bricklane4"),
              let journalImage = UIImage(named: "journal1"),
              let journalImage2 = UIImage(named: "journal2"),
              let journalImage3 = UIImage(named: "journal3"),
              let journalImage4 = UIImage(named: "journal4"),
              let coffeeroastersImage = UIImage(named: "coffeeroasters1"),
              let coffeeroastersImage2 = UIImage(named: "coffeeroasters2"),
              let coffeeroastersImage3 = UIImage(named: "coffeeroasters3"),
              let coffeeroastersImage4 = UIImage(named: "coffeeroasters4"),
              let auntbilliesImage = UIImage(named: "auntbillies1"),
              let auntbilliesImage2 = UIImage(named: "auntbillies2"),
              let auntbilliesImage3 = UIImage(named: "auntbillies3"),
              let auntbilliesImage4 = UIImage(named: "auntbillies4"),
              let aixcafeImage = UIImage(named:"aixcafe1"),
              let aixcafeImage2 = UIImage(named:"aixcafe2"),
              let aixcafeImage3 = UIImage(named:"aixcafe3"),
              let aixcafeImage4 = UIImage(named:"aixcafe4"),
              let kettleblackImage = UIImage(named: "kettleblack1"),
              let kettleblackImage2 = UIImage(named: "kettleblack2"),
              let kettleblackImage3 = UIImage(named: "kettleblack3"),
              let kettleblackImage4 = UIImage(named: "kettleblack4")
        else {
            print("One or more images not found")
            return
        }
        
        // Create cafe instances with the defined opening and closing times
        cafes = [
            Cafe(id: "0", name: "Higher Ground", address: " 650 Little Bourke St, Melbourne VIC 3000, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.8144645690918, longitude: 144.9585418701172), openingHours: HigherHours.flatMap {$0}, description: "Modern, upscale bites in an industrial-chic former power station with exposed-brick walls.", images:[higherImage, higherImage2,higherImage3,higherImage4]),
            Cafe(id: "1", name: "Cafe Kinetic", address: "103 Flinders Ln, Melbourne VIC 3000, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.81537628173828, longitude: 144.97068786621094),openingHours: KineticHours.flatMap {$0}, description: "Smart, casual cafe for a buffet of roasts, vegetables and salad, with chandeliers and ample seating", images:[kineticImage,kineticImage2,kineticImage3,kineticImage4]),
            Cafe(id: "2", name: "Aix Cafe", address: "24 Centre Pl, Melbourne VIC 3000, Australia", rating: 3, coordinate: LocationCoordinate(latitude: -37.816699, longitude:144.9656491), openingHours:AixHours.flatMap {$0}, description: "Tiny creperie with warm vibe, offering sweet choices like nutella and mango, or savoury peking duck.", images: [aixcafeImage, aixcafeImage2, aixcafeImage3,aixcafeImage4]),
            Cafe(id: "3", name: "Brick Lane Melbourne", address: " 33 Guildford Ln, Melbourne VIC 3000, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.8114349, longitude: 144.9598528), openingHours: BrickLaneHours.flatMap {$0}, description: "Menu", images:[bricklaneImage, bricklaneImage2, bricklaneImage3, bricklaneImage4]),
            Cafe(id: "4", name: "The Journal Cafe", address: "253 Flinders Ln, Melbourne VIC 3000, Australia", rating: 5, coordinate: LocationCoordinate(latitude: -37.817840576171875, longitude: 144.9658660888672), openingHours: JournalHours.flatMap {$0}, description: "Light meals in a spacious, high-ceilinged cafe with suspended bookshelves and retro furniture.", images:[journalImage,journalImage2, journalImage3, journalImage4]),
            Cafe(id: "5", name: "The Kettle Black", address: "50 Albert Rd, South Melbourne VIC 3205, Australia", rating: 4, coordinate: LocationCoordinate(latitude: -37.83432388305664, longitude: 144.9714813232422), openingHours: KettleHours.flatMap {$0}, description: "Modern Australian cafe fare served in a chic terrace house with white walls & modern lighting.", images: [kettleblackImage, kettleblackImage2, kettleblackImage3, kettleblackImage4]),
            Cafe(id: "6", name: "Coffee Roasters", address: "St Ali Coffee Roasters, 12-18 Yarra Place, South Melbourne VIC 3205, Australia", rating: 5, coordinate: LocationCoordinate(latitude: -37.8313313, longitude: 144.9604687), openingHours: ALiHours.flatMap {$0}, description: "Warm, low-lit cafe in converted warehouse with exposed brick and furniture made from old lift doors.", images: [coffeeroastersImage,coffeeroastersImage2,coffeeroastersImage3,coffeeroastersImage4]),
            Cafe(id: "7", name: "Aunt Billies Cafe", address: "184 Surrey Rd, Blackburn VIC 3130, Australia", rating: 5, coordinate: LocationCoordinate(latitude:-37.8162727355957, longitude: 145.15655517578125), openingHours: AuntHours.flatMap {$0}, description: "Warm, low-lit cafe in converted warehouse with exposed brick and furniture made from old lift doors.", images:[auntbilliesImage,auntbilliesImage2,auntbilliesImage3,auntbilliesImage4]),
        ]
        
        
        // Helper function to create a Date object with the specified hour and minute
        func createDate(hour: Int, minute: Int) -> Date {
            let now = Date() // Get the current date and time
              let calendar = Calendar.current
              var components = calendar.dateComponents([.year, .month, .day], from: now)
              components.hour = hour
              components.minute = minute
          
            // Set the time zone to Melbourne's time zone (Australian Eastern Standard Time)
            let timeZone = TimeZone(identifier: "Australia/Melbourne")!
            components.timeZone = timeZone
            // Assuming today's date for simplicity, you may set other date components as needed
            return Calendar.current.date(from: components)!
        }

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
    
    

