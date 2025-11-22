import Foundation

struct DownloadItem: Identifiable {
    let id = UUID()
    let fileName: String
    var progress: Double
    var isFinished: Bool
    var url: URL
}
