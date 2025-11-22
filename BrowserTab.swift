import Foundation

struct BrowserTab: Identifiable {
    let id: UUID
    var url: URL
    var title: String = "New Tab"
    var thumbnail: Data? = nil
    var isPrivate: Bool = false
}
