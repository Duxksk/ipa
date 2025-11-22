import Foundation
import WebKit

class AdBlocker {
    static func install(into config: WKWebViewConfiguration) {
        guard let path = Bundle.main.path(forResource: "adblock", ofType: "json") else {
            print("Adblock JSON not found")
            return
        }
        
        guard let json = try? String(contentsOfFile: path) else {
            print("Failed to load adblock JSON")
            return
        }
        
        WKContentRuleListStore.default().compileContentRuleList(
            forIdentifier: "adblock",
            encodedContentRuleList: json
        ) { list, error in
            if let error = error {
                print("Compile error: \(error)")
                return
            }
            if let list = list {
                config.userContentController.add(list)
                print("Adblock installed")
            }
        }
    }
}
