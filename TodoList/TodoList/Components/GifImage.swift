//
//  GifImage.swift
//  TodoList
//
//  Created by Pat on 2022/08/28.
//

import SwiftUI
import WebKit
    
struct GifImage: UIViewRepresentable{
    private let name: String
    ///Making this similiar to image
    init(_ name:String){
        self.name = name
    }
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        ///get access to the files in the application
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        ///Extract information from data
        let data = try! Data(contentsOf: url)
        ///Load Resource in webview
        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: (url.deletingLastPathComponent()))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}


struct GifImage_Previews: PreviewProvider{
    static var previews: some View{
        GifImage("appIcon")
    }
}
