import SwiftUI

extension View {
    func neonBorder(color: Color = Color.cyan, lineWidth: CGFloat = 1.4) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        color.opacity(0.9)
                            .shadow(color: color.opacity(0.7), radius: 6)
                            .shadow(color: color.opacity(0.4), radius: 12)
                        ,
                        lineWidth: lineWidth
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
