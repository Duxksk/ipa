import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject var model = BrowserModel()
    @StateObject var controller: WebViewController
    
    init() {
        let m = BrowserModel()
        _model = StateObject(wrappedValue: m)
        _controller = StateObject(wrappedValue: WebViewController(model: m))
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                topBar
                WebView(controller: controller)
                    .edgesIgnoringSafeArea(.bottom)
                bottomBar
            }
        }
        .onReceive(model.$urlString, perform: { url in
            if let u = URL(string: url) {
                controller.load(url: u)
            }
        })
        .onAppear {
            controller.webView.addObserver(
                model,
                forKeyPath: "estimatedProgress",
                options: .new,
                context: nil
            )
        }
    }
    
    // MARK: - Top Bar (주소창 + 새로고)
    var topBar: some View {
        HStack {
            TextField("Search or URL", text: $model.urlString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(8)
            
            Button(action: { controller.webView.reload() }) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 8)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .background(Blur(style: .systemThinMaterialDark))
        .neonBorder()
    }
    
    // MARK: - Bottom Bar (뒤/앞, 탭, 데스크탑)
    var bottomBar: some View {
        HStack {
            Button(action: { controller.webView.goBack() }) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20, weight: .bold))
            }
            .disabled(!model.canGoBack)
            
            Spacer()
            
            Button(action: { controller.webView.goForward() }) {
                Image(systemName: "chevron.forward")
                    .font(.system(size: 20, weight: .bold))
            }
            .disabled(!model.canGoForward)
            
            Spacer()
            
            Button(action: { model.showTabSwitcher = true }) {
                Image(systemName: "square.on.square")
                    .font(.system(size: 22, weight: .bold))
            }
            
            Spacer()
            
            Button(action: {
                model.isDesktopMode.toggle()
                controller.webView.customUserAgent = model.isDesktopMode ?
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15)" :
                nil
                controller.webView.reload()
            }) {
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 22))
            }
            
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 12)
        .background(Blur(style: .systemChromeMaterialDark))
        .neonBorder()
    }
}

// MARK: - Blur View
struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
