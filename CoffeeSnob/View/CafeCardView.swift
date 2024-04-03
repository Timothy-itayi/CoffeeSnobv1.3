import UIKit

class CardView: UIView {
    // UI components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Cafes Nearby"
        return label
    }()
    
    private let cafeListView: UITableView = {
        let tableView = UITableView()
        // Configure table view properties as needed
        return tableView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(CardView.self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Closure to handle close button action
    var onCloseButtonTapped: (() -> Void)?
    
    // Initialize the card view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // Setup UI components and constraints
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        addSubview(titleLabel)
        addSubview(cafeListView)
        addSubview(closeButton)
        
        // Add constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cafeListView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            cafeListView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            cafeListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cafeListView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cafeListView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            
            closeButton.topAnchor.constraint(equalTo: cafeListView.bottomAnchor, constant: 8),
            closeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    // Method to update cafe data
    func updateCafes(_ cafes: [String]) {
        // Update cafe list view with data
    }
    
    // Action method for close button
    @objc private func closeButtonTapped() {
        onCloseButtonTapped?()
    }
}
