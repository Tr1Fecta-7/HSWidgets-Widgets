//
//  ContentView.swift
//  SwiftUI-Test
//
//  Created by Tr1Fecta on 04/05/2020.
//  Copyright © 2020 Tr1Fecta. All rights reserved.
//

import SwiftUI
import WebKit


struct WebView : UIViewRepresentable {
      
    let request: URLRequest
      
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
      
}
  

struct HSDonationContentView: View {
    var body: some View {
        VStack {
            WebView(request: URLRequest(url: URL(string: "https://paypal.me/PUT USERNAME HERE")!))
        }
      
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HSDonationContentView()
        
    }
}
