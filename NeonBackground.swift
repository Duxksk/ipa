import SwiftUI

struct NeonBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.cyan.opacity(0.4),
                Color.blue.opacity(0.3),
                Color.purple.opacity(0.35)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .blur(radius: 40)
        .edgesIgnoringSafeArea(.all)
    }
}
