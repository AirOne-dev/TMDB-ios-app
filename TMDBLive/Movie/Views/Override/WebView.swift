//
//  WebView.swift
//  TMDBLive
//
//  Created by Erwan Martin on 04/04/2022.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        let wv = WKWebView();
        ApiViewModel.webView = wv;
        return wv;
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
