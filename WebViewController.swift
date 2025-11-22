import Foundation
import SwiftUI
import WebKit

class WebViewController: NSObject, WKNavigationDelegate, WKUIDelegate, WKDownloadDelegate, ObservableObject {

    @Published var webView = WKWebView()
    @ObservedObject var model: BrowserModel
    
    init(model: BrowserModel) {
        self.model = model
        super.init()
        
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.defaultWebpagePreferences.allowsContentJavaScript = true

        // 광고 차단 RuleList 적용
        if let path = Bundle.main.path(forResource: "adblock", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let json = String(data: data, encoding: .utf8) {

            WKContentRuleListStore.default().compileContentRuleList(
                forIdentifier: "adblock",
                encodedContentRuleList: json
            ) { list, error in
                if let list = list {
                    config.userContentController.add(list)
                }
            }
        }

        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        load(url: URL(string: model.urlString)!)
    }
    
    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    // 다운로드 처리
    func webView(_ webView: WKWebView,
                 navigationAction: WKNavigationAction,
                 didBecome download: WKDownload) {
        download.delegate = self
    }
}
