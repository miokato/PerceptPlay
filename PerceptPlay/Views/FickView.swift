//
//  FickView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/20.
//

import SwiftUI

struct FickShapeView: View {
    var isRotated = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .stroke()
                        .frame(width: 100, height: 20)
                    Text("A")
                }
                ZStack {
                    Rectangle()
                        .stroke()
                        .frame(width: 20, height: 100)
                    Text("B")
                }
            }
        }
        .rotationEffect(isRotated ? Angle(degrees: -90) : Angle(degrees: 0))
    }
}

struct FickView: View {
    @State var isRotated = false
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Fick.description")
                        .font(.caption)
                    Text("Which is longer, A or B?")
                        .font(.headline)
                    Text("Tap a button to rotate a shape!")
                        .font(.subheadline)
                }
            }
            Spacer()
            FickShapeView(isRotated: isRotated)
            Spacer()
            Button("Tap") {
                withAnimation {
                    isRotated.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 24)
        .navigationTitle("Fick.title")
    }
}

#Preview {
    FickView()
        .environment(\.locale, .init(identifier: "ja"))
}
