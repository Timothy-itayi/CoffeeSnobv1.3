import UIKit
import CoreLocation

class CafeViewController: UIViewController {
    // Cafe object to display details
    var cafe: CafeManager.Cafe

    // CafeManager to access cafe array
    var cafeManager: CafeManager?

    // UI elements
    let nameLabel = UILabel()
    let scrollView = UIScrollView()
    var imageViews = [UIImageView]()
    let addressLabel = UILabel()
    let hoursLabel = UILabel()
    let descriptionLabel = UILabel()


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
    }

    // MARK: - UI Setup
    private func setupViews() {
        view.backgroundColor = .white

        // Add name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 2
        nameLabel.font = UIFont.systemFont(ofSize: 34)
        view.addSubview(nameLabel)

        // Add scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // Add hours label
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.numberOfLines = 0
        view.addSubview(hoursLabel)

        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        view.addSubview(addressLabel)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)

    
        // Layout constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),


            hoursLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            hoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hoursLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 600),

    
      
        ])
    }

    // MARK: - Display Cafe Details
    private func displayCafeDetails() {
        nameLabel.text = cafe.name
        descriptionLabel.text = cafe.description
        addressLabel.text = cafe.address
        var previousImageView: UIImageView?
        // Add images to scrollView
              for image in cafe.images {
                  let imageView = UIImageView(image: image)
                  imageView.contentMode = .scaleAspectFill
                  imageView.clipsToBounds = true
                  imageView.translatesAutoresizingMaskIntoConstraints = false
                  scrollView.addSubview(imageView)
                  imageViews.append(imageView)
                  
                  // Set constraints relative to the previous image view
                        NSLayoutConstraint.activate([
                            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                            imageView.heightAnchor.constraint(equalToConstant: 400)
                        ])
                        
                        if let previous = previousImageView {
                            // If there's a previous image view, constrain the top of the current image view to the bottom of the previous one
                            NSLayoutConstraint.activate([
                                imageView.topAnchor.constraint(equalTo: previous.bottomAnchor),
                            ])
                        } else {
                            // If there's no previous image view, this is the first one, so constrain its top to the top of the scrollView
                            NSLayoutConstraint.activate([
                                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                            ])
                        }
                        
                        previousImageView = imageView
                    }

                    scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: CGFloat(cafe.images.count) * 400)
        
        

        // Determine status and time text
        let statusText: String
        let timeText: String
        if cafe.isOpen() {
            statusText = "Open"
            hoursLabel.textColor = .green
            timeText = "Closes \(closingTimeFormatted(cafe.closingTime))"
        } else {
            statusText = "Closed"
            hoursLabel.textColor = .red
            timeText = "opens \(openingTimeFormatted(cafe.openingTime)) "
        }

        // Concatenate status and time text
        let statusAndTimeText = "\(statusText) \(timeText)"

        // Set label text
        hoursLabel.text = statusAndTimeText
    }



    // Helper method to format closing time
    func closingTimeFormatted(_ closingTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: closingTime)
    }

    // Helper method to format opening time
    func openingTimeFormatted(_ openingTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: openingTime)
    }
}
