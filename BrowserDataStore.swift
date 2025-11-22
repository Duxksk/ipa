import Foundation

class BrowserDataStore: ObservableObject {
    @Published var bookmarks: [String] = []
    @Published var history: [String] = []
    
    private let bookmarksKey = "browser_bookmarks"
    private let historyKey = "browser_history"
    
    init() {
        load()
    }
    
    func load() {
        bookmarks = UserDefaults.standard.stringArray(forKey: bookmarksKey) ?? []
        history = UserDefaults.standard.stringArray(forKey: historyKey) ?? []
    }
    
    func save() {
        UserDefaults.standard.set(bookmarks, forKey: bookmarksKey)
        UserDefaults.standard.set(history, forKey: historyKey)
    }
    
    func addBookmark(_ url: String) {
        if !bookmarks.contains(url) {
            bookmarks.append(url)
            save()
        }
    }
    
    func removeBookmark(_ url: String) {
        bookmarks.removeAll { $0 == url }
        save()
    }
    
    func addHistory(_ url: String) {
        history.append(url)
        save()
    }
    
    func clearHistory() {
        history.removeAll()
        save()
    }
}
