import UIKit
import TomTomSDKSearchOnline
import TomTomSDKSearch
import TomTomSDKMapDisplay


protocol SearchBarViewControllerDelegate: AnyObject {
    func didSearchForCafes(withResults results: [SearchResult])
}

class SearchBarViewController: UIViewController, UISearchBarDelegate {
    
    
    weak var delegate: SearchBarViewControllerDelegate?
    private let searchBar = UISearchBar()
    private let onlineSearch = OnlineSearchFactory.create(apiKey: "pI4kmVlG64hsmsxz9fLKoMtXOmLVgaJW")
    private let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else {
            // Handle empty search query
            return
        }
        let searchOptions = SearchOptions(query: query)
        onlineSearch.search(options: searchOptions) { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didSearchForCafes(withResults: response.results)
            case .failure(let error):
                print("Search error: \(error)")
            }
        }
    }
}

