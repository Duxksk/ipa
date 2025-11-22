import SwiftUI

struct DownloadListView: View {
    @ObservedObject var manager = DownloadManager.shared
    
    var body: some View {
        VStack {
            Text("Downloads")
                .font(.system(size: 22, weight: .bold))
                .padding(.top, 14)
            
            if manager.downloads.isEmpty {
                Spacer()
                Text("No downloads yet.")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List {
                    ForEach(manager.downloads) { item in
                        DownloadRow(item: item)
                    }
                }
            }
        }
        .background(Color.black.opacity(0.85))
        .ignoresSafeArea()
    }
}
