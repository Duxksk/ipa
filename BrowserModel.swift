import SwiftUI
import Combine
import WebKit

class BrowserModel: ObservableObject {
    @Published var urlString: String = "https://www.google.com"
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var isLoading = false
    @Published var progress: Double = 0.0
    @Published var isDesktopMode = false
    @Published var showTabSwitcher = false
    @Published var isPrivateMode = false
    
    // 탭 리스트
    @Published var tabs: [BrowserTab] = [
        BrowserTab(id: UUID(), url: URL(string: "https://www.google.com")!)
    ]
    @Published var currentTabID: UUID?
    
    // 다운로드 리스트
    @Published var downloads: [DownloadItem] = []
    
    init() {
        currentTabID = tabs.first?.id
    }
    
    func switchToTab(_ id: UUID) {
        currentTabID = id
    }
    
    func addNewTab(privateMode: Bool = false) {
        let new = BrowserTab(
            id: UUID(),
            url: URL(string: "https://www.google.com")!,
            isPrivate: privateMode
        )
        tabs.append(new)
        currentTabID = new.id
    }
    
    func closeTab(_ id: UUID) {
        tabs.removeAll { $0.id == id }
        
        if tabs.isEmpty {
            addNewTab()
        } else {
            currentTabID = tabs.last?.id
        }
    }
}
