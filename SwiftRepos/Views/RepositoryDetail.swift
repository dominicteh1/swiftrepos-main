import SwiftUI
import WebKit

struct RepositoryDetail: View {
    var repository: Repository
    
    // State variable to control the presentation of the WebView
    @State private var showWebView = false
    
    var body: some View {
        VStack {
            Text(repository.name)
                .font(.largeTitle)
                .padding()
            
            Text(repository.itemDescription.isEmpty ? "No Description" : repository.itemDescription)
                .padding()
            
            // Button to open the web view
            Button(action: {
                // When the button is clicked, show the web view
                showWebView = true
            }) {
                Text("View on GitHub")
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationBarTitle("Repository Detail", displayMode: .inline)
        .sheet(isPresented: $showWebView) {
            // Create the URL request using the repository's URL
            if let url = URL(string: repository.htmlURL) {
                WebView(request: URLRequest(url: url))
            }
        }
    }
}

// WebView implementation
struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

// Preview provider for RepositoryDetail
struct RepositoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        // Sample repository for preview
        let sampleRepo = Repository(
            id: 1,
            name: "Sample Repository",
            htmlURL: "https://github.com/sample/repo",
            itemDescription: "This is a sample repository for demonstration."
        )
        
        RepositoryDetail(repository: sampleRepo)
    }
}
