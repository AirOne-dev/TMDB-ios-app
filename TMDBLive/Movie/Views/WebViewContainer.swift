//
//  WebViewContainer.swift
//  TMDBLive
//
//  Created by Erwan Martin on 04/04/2022.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
@ObservedObject var webViewModel: WebViewModel
func makeCoordinator() -> WebViewContainer.Coordinator {
Coordinator(self, webViewModel)
    }
func makeUIView(context: Context) -> WKWebView {
guard let url = URL(string: self.webViewModel.url) else {
return WKWebView()
        }
let request = URLRequest(url: url)
let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
return webView
    }
func updateUIView(_ uiView: WKWebView, context: Context) {
if webViewModel.shouldGoBack {
            uiView.goBack()
            webViewModel.shouldGoBack = false
        }
    }
}
