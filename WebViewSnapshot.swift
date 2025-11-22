import UIKit
import WebKit

extension WKWebView {
    func captureSnapshot(completion: @escaping (UIImage?) -> Void) {
        let config = WKSnapshotConfiguration()
        config.rect = self.bounds
        
        self.takeSnapshot(with: config) { image, error in
            completion(image)
        }
    }
}
