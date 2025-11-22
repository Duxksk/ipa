import Foundation
import WebKit

class DownloadManager: NSObject, ObservableObject, WKDownloadDelegate {
    @Published var downloads: [DownloadItem] = []
    
    static let shared = DownloadManager()
    private override init() {}
    
    // 실제 파일 저장 경로
    private func destinationURL(for fileName: String) -> URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent(fileName)
    }
    
    // WKDownloadDelegate — 다운로드 생성
    func download(_ download: WKDownload,
                  decideDestinationUsing response: URLResponse,
                  suggestedFilename: String,
                  completionHandler: @escaping (URL?) -> Void) {
        
        let dest = destinationURL(for: suggestedFilename)
        
        // 기존 파일 있으면 삭제
        try? FileManager.default.removeItem(at: dest)
        
        completionHandler(dest)
        
        let item = DownloadItem(
            fileName: suggestedFilename,
            progress: 0,
            isFinished: false,
            url: dest
        )
        downloads.append(item)
    }
    
    // 진행률 업데이트
    func download(_ download: WKDownload, didWriteData bytesWritten: Int64,
                  totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard let index = downloads.firstIndex(where: { !$0.isFinished }) else { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        downloads[index].progress = progress
        objectWillChange.send()
    }
    
    // 다운로드 완료
    func downloadDidFinish(_ download: WKDownload) {
        guard let index = downloads.firstIndex(where: { !$0.isFinished }) else { return }
        
        downloads[index].isFinished = true
        downloads[index].progress = 1.0
        objectWillChange.send()
    }
}
