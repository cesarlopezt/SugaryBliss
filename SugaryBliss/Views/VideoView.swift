//
//  VideoView.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/15/23.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    let baseURL = "https://www.youtube.com/embed/"
    let videoId: String
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "\(baseURL)\(videoId)") else {
            return
        }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videoId: "rp8Slv4INLk")
    }
}
