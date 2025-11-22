import SwiftUI

struct TabButton: View {
    let count: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.2))
                .frame(width: 44, height: 44)
                .overlay(Circle().stroke(Color.cyan, lineWidth: 1.4))
            
            Text("\(count)")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
        }
    }
}
