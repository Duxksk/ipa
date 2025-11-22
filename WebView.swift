import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var controller: WebViewController
    
    func makeUIView(context: Context) -> WKWebView {
        controller.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 업데이트 불필요
    }
}
