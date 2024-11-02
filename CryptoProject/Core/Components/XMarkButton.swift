//
//  XMarkButton.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 25.10.2024.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presMode
    var body: some View {
        Button(action: {
            dismiss()
           
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                
        })
    }
}

#Preview {
    XMarkButton()
}
