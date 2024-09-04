//
//  HtmlView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI
import WebKit

/// Adapted from: https://alexpaul.dev/2023/01/19/rendering-web-content-in-swiftui-using-uiviewrepresentable-html-and-css/
struct HTMLView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var htmlString: String {
        guard let path = Bundle.main.path(forResource: "layout", ofType: "html") else {
            fatalError("Layout not found.")
        }
        
        guard let layout = (try? String(contentsOfFile: path))?.split(separator: "<slot />") else {
            fatalError("Cannot convert layout to String.")
        }
        
        return String(layout[0] + content + layout[1])
    }
 
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)

        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
 
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}
