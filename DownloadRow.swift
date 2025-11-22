import SwiftUI

struct DownloadRow: View {
    let item: DownloadItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.fileName)
                .foregroundColor(.white)
                .lineLimit(1)
            
            ProgressView(value: item.progress)
                .progressViewStyle(LinearProgressViewStyle())
            
            if item.isFinished {
                Text("Completed")
                    .font(.system(size: 14))
                    .foregroundColor(.green)
            } else {
                Text("\(Int(item.progress * 100))%")
                    .font(.system(size: 14))
                    .foregroundColor(.cyan)
            }
        }
        .padding(.vertical, 4)
    }
}
