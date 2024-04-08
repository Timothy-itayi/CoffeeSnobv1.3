import UIKit
import CoreLocation
class CafeViewController: UIViewController {
    // Cafe object to display details
    var cafe: CafeManager.Cafe
    
    
    // CafeManager to access cafe array
    var cafeManager: CafeManager?
    
    // UI elements
    let nameLabel = UILabel()
    let cafeImageView = UIImageView()
    let addressLabel = UILabel()
    let hoursLabel = UILabel()
    // MARK: - Initialization
    
    init(cafe: CafeManager.Cafe, cafeManager: CafeManager) {
        self.cafe = cafe
        self.cafeManager = cafeManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        displayCafeDetails()
        
        modalPresentationStyle = .overCurrentContext
    }
    
    // MARK: - UI Setup
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let bottomSheetHeight: CGFloat = 5
        
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: bottomSheetHeight)
        
        
        
        // Add name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 2
        view.addSubview(nameLabel)
        
        // Add cafe image view
        cafeImageView.translatesAutoresizingMaskIntoConstraints = false
        cafeImageView.contentMode = .scaleAspectFill
        cafeImageView.clipsToBounds = true
        view.addSubview(cafeImageView)
        
        
        // Add address label
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.numberOfLines = 0
        view.addSubview(hoursLabel)
        
        
        // Layout constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cafeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cafeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cafeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cafeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            hoursLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            hoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hoursLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    // MARK: - Display Cafe Details
    
    private func displayCafeDetails() {
        nameLabel.text = cafe.name
        
   
        
        // Assuming "YourCustomFontName" is the name of your custom font
        if let customFont = UIFont(name: "Inter-Bold", size: 34) {
            nameLabel.font = customFont
        } else {
            // Fallback to system font if custom font is not available
            nameLabel.font = UIFont.systemFont(ofSize: 34)
        }
   
            
            
        
            // Load cafe image
            if let imageURL = cafe.imageURL, let imageData = try? Data(contentsOf: imageURL) {
                cafeImageView.image = UIImage(data: imageData)
            }
            
            
            // Determine status and time text
            let statusText: String
            let timeText: String
            if cafe.isOpen() {
                statusText = "Open"
                hoursLabel.textColor = .green
                timeText = "Closes \(closingTimeFormatted())"
            } else {
                statusText = "Closed"
                hoursLabel.textColor = .red
                timeText = ""
            }
            
            // Concatenate status and time text
            let statusAndTimeText = "\(statusText) \(timeText)"
            
            // Set label text
            hoursLabel.text = statusAndTimeText
        }
        // Helper method to format closing time
        private func closingTimeFormatted() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: cafe.closingTime)
        }
    
        
        
        
    }

