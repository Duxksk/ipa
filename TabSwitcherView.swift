import SwiftUI
import WebKit

struct TabSwitcherView: View {
    @ObservedObject var model: BrowserModel
    @ObservedObject var controller: WebViewController
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        model.showTabSwitcher = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 22, weight: .bold))
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        model.addNewTab(privateMode: false)
                        model.showTabSwitcher = false
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 26, weight: .bold))
                            .padding()
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(model.tabs) { tab in
                            TabThumbnailView(
                                tab: tab,
                                isSelected: model.currentTabID == tab.id,
                                onSelect: {
                                    model.switchToTab(tab.id)
                                    controller.load(url: tab.url)
                                    model.showTabSwitcher = false
                                },
                                onClose: {
                                    model.closeTab(tab.id)
                                }
                            )
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    model.addNewTab(privateMode: true)
                    model.showTabSwitcher = false
                }) {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                        Text("New Private Tab")
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(14)
                }
                .padding(.bottom, 40)
            }
        }
        .animation(.easeInOut, value: model.tabs)
    }
}
