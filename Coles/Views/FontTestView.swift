//
//  FontTestView.swift
//  Coles
//
//  Created by Tim Kreger on 16/10/2025.
//

import SwiftUI

struct FontTestView: View {
    var body: some View {
        VStack {
            Text("Pork, fennel and sage")
                .font(.custom("Poppins-SemiBold", size: 32))
            Text("Pork, fennel and sage")
                .font(.custom("Poppins-Regular", size: 32))
            
            Text("RECIPE")
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(.red)
        }
    }
}

#Preview {
    FontTestView()
}
