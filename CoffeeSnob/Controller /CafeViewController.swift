import UIKit
import CoreLocation
class CafeViewController: UIViewController {
    // Cafe object to display details
       var cafe: CafeManager.Cafe

  
    // CafeManager to access cafe array
    var cafeManager: CafeManager?
    
    // UI elements
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    
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
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(nameLabel)
        
        // Add address label
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        view.addSubview(addressLabel)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Display Cafe Details
    
    private func displayCafeDetails() {
        nameLabel.text = cafe.name
       
    }
}
