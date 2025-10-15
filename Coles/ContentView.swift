//
//  ContentView.swift
//  Coles
//
//  Created by Tim Kreger on 16/10/2025.
//

import SwiftUI

struct ContentView: View {
    // Determine the orientation using the GeometryReader
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // Landscape orientation
                LandscapeView()
            } else {
                // Portrait orientation
                PortraitView()
            }
        }
    }
}

struct PortraitView: View {
    var body: some View {
        Text("Portrait View")
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct LandscapeView: View {
    var body: some View {
        Text("Landscape View")
            .font(.largeTitle)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
