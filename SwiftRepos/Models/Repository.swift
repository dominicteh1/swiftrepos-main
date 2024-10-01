import Foundation
import Alamofire


// MARK: - Repository Struct
struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let htmlURL: String
    let itemDescription: String
    
    // CodingKeys for mapping JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case htmlURL = "html_url"
        case itemDescription = "description"
    }
}

struct Repositories: Codable {
    let items: [Repository]
}
