import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataStore: BrowserDataStore
    @ObservedObject var engineManager: SearchEngineManager
    @ObservedObject var privateMode: PrivateModeManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("검색 엔진")) {
                    Picker("기본 검색 엔진", selection: $engineManager.engine) {
                        ForEach(SearchEngine.allCases, id: \.self) { engine in
                            Text(engine.rawValue)
                        }
                    }
                }
                
                Section(header: Text("프라이빗 모드")) {
                    Toggle("Private Browsing", isOn: $privateMode.isPrivate)
                }
                
                Section(header: Text("데이터 삭제")) {
                    Button("히스토리 전체 삭제") {
                        dataStore.clearHistory()
                    }.foregroundColor(.red)
                }
                
                Section(header: Text("북마크")) {
                    ForEach(dataStore.bookmarks, id: \.self) { url in
                        Text(url)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") { dismiss() }
                }
            }
        }
    }
}
