import UIKit

protocol SearchBarViewDelegate: AnyObject {
    func didSearchForCafes()
}

class SearchBarView: UIView {
    weak var delegate: SearchBarViewDelegate?

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Where to....."
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .white // Background color of the search bar
        searchBar.tintColor = .black // Tint color of the cancel button and text cursor
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchBar()
    }

    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension SearchBarView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didSearchForCafes()
        searchBar.resignFirstResponder()
    }
}
