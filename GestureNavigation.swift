import SwiftUI
import WebKit

class GestureNavigation: NSObject, UIGestureRecognizerDelegate {
    weak var webView: WKWebView?
    
    init(webView: WKWebView) {
        self.webView = webView
        super.init()
        setup()
    }
    
    private func setup() {
        guard let view = webView else { return }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let webView = webView else { return }
        
        let translation = gesture.translation(in: webView).x
        
        if gesture.state == .ended {
            if translation > 80 {
                if webView.canGoBack { webView.goBack() }
            } else if translation < -80 {
                if webView.canGoForward { webView.goForward() }
            }
        }
    }
}
