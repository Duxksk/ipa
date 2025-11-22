import Foundation

enum SearchEngine: String, CaseIterable {
    case google = "Google"
    case duck = "DuckDuckGo"
    case naver = "Naver"
    
    var url: String {
        switch self {
        case .google: return "https://www.google.com/search?q="
        case .duck: return "https://duckduckgo.com/?q="
        case .naver: return "https://search.naver.com/search.naver?query="
        }
    }
}

class SearchEngineManager: ObservableObject {
    @Published var engine: SearchEngine = .google
    
    private let key = "search_engine"
    
    init() {
        if let saved = UserDefaults.standard.string(forKey: key),
           let e = SearchEngine(rawValue: saved) {
            engine = e
        }
    }
    
    func setEngine(_ eng: SearchEngine) {
        engine = eng
        UserDefaults.standard.set(eng.rawValue, forKey: key)
    }
}
