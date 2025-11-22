import SwiftUI
import WebKit

class ScrollDetector: NSObject, UIScrollViewDelegate, ObservableObject {
    @Published var isScrollingDown: Bool = false
    private var lastOffset: CGFloat = 0
    
    func attach(to webView: WKWebView) {
        webView.scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset > lastOffset + 10 {
            isScrollingDown = true
        } else if offset < lastOffset - 10 {
            isScrollingDown = false
        }
        
        lastOffset = offset
    }
}
