import SwiftUI
import Alamofire


struct RepositoryRow: View {
    let repository: Repository  // A reference to the Repository object

    var body: some View {
        VStack(alignment: .leading) {
            // Display the repository's name with headline font
            Text(repository.name)
                .font(.headline)
            
            // Display the repository's description with subheadline font
            Text(repository.itemDescription.isEmpty ? "No description available" : repository.itemDescription)
                .font(.subheadline)
                .foregroundColor(.gray)  // Optional: Change color for better visibility
        }
        .padding()  // Optional: Add padding for better layout
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with sample data
        let sampleRepository = Repository(id: 1, name: "Sample Repository", htmlURL: "https://example.com", itemDescription: "This is a sample description.")
        
        RepositoryRow(repository: sampleRepository)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
