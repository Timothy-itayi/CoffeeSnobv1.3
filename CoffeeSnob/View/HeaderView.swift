import UIKit

protocol HeaderViewDelegate: AnyObject {
    // Define any methods or properties required by the delegate
}

class HeaderView: UIView {
    weak var delegate: HeaderViewDelegate?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Header View"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        // Add header label
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        // Set background color
        backgroundColor = .lightGray
    }
}
