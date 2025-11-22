import Foundation
import WebKit

class PrivateModeManager: ObservableObject {
    @Published var isPrivate: Bool = false
    
    func configure(_ webView: WKWebView) {
        if isPrivate {
            let config = webView.configuration
            config.websiteDataStore = .nonPersistent()
        }
    }
}
