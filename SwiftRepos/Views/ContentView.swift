import SwiftUI
import Alamofire

struct ContentView: View {
    
    // ObservedObject instance of ViewModel
    @ObservedObject var viewModel = ViewModel()
    
    // State variables
    @State private var searchField: String = ""
    @State private var displayedRepos: [Repository] = []
    
    var body: some View {
        // Create a binding for the searchField
        let binding = Binding<String>(
            get: {
                self.searchField
            },
            set: {
                self.searchField = $0
                self.viewModel.search(searchText: self.searchField)
                self.displayRepos()
            }
        )
        
        NavigationView { // Add NavigationView to enable navigation
            VStack {
                // Search TextField
                TextField("Search", text: binding)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // List of repositories
                List(displayedRepos, id: \.id) { repo in
                    NavigationLink(destination: RepositoryDetail(repository: repo)) { // Add NavigationLink
                        RepositoryRow(repository: repo) // Assuming RepositoryRow takes a Repository
                    }
                }
            }
            .navigationBarTitle("Swift Repos") // Set the navigation bar title
        }
        .onAppear(perform: loadData) // Load data when view appears
    }
    
    // Load data method
    func loadData() {
        Task {
            let repos = await Parser().fetchRepositories()
            self.viewModel.repos = repos
            self.displayRepos() // Update displayedRepos after fetching
        }
    }
    
    // Display repositories based on search field
    func displayRepos() {
        if searchField.isEmpty {
            displayedRepos = viewModel.repos
        } else {
            displayedRepos = viewModel.filteredRepos
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
