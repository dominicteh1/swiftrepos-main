import Foundation
import Combine
import Alamofire


class ViewModel: ObservableObject {
    // Instance of parser (if needed)
    
    // MARK: Fields
    @Published var repos: [Repository] = []  // An array of all the Repository objects
    @Published var searchText: String = ""    // The search bar text as a String
    @Published var filteredRepos: [Repository] = [] // An array of the filtered Repository objects

    // MARK: Methods
    func search(searchText: String) {
        self.filteredRepos = self.repos.filter { repo in
            return repo.name.lowercased().contains(searchText.lowercased())
        }
    }
}
