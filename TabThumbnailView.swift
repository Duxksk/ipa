import SwiftUI

struct TabThumbnailView: View {
    let tab: BrowserTab
    let isSelected: Bool
    let onSelect: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                if let data = tab.thumbnail, let img = UIImage(data: data) {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 280)
                        .clipped()
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(isSelected ? Color.cyan : Color.clear, lineWidth: 3)
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 180, height: 280)
                        .cornerRadius(14)
                        .overlay(
                            Text(tab.title)
                                .foregroundColor(.white.opacity(0.7))
                        )
                }
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 26))
                        .padding(6)
                }
            }
            
            Text(tab.title)
                .lineLimit(1)
                .foregroundColor(.white)
                .padding(.top, 6)
        }
        .onTapGesture(perform: onSelect)
    }
}
