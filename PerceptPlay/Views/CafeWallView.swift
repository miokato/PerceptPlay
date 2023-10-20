//
//  CafeWallView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/20.
//

import SwiftUI

struct CafeWallShape: View {
    var isReverse: Bool = false
    var blockWidth: CGFloat {
        isReverse ? 0 : 26
    }
    
    let blockHeight: CGFloat = 16
    let numHorizontalBlocks: Int = 7
    let numVerticalBlocks: Int = 5
    let lineHeight: CGFloat = 2
    let horizontalOffset: CGFloat = 20
    let horizontalSpace: CGFloat = 20
    var spaceFragments = [0, 1, 2, 1, 0, 1, 2, 1, 0]
    
    var body: some View {
        GeometryReader { gr in
            VStack(spacing: 0) {
                ForEach(spaceFragments, id: \.self) { i in
                    Rectangle()
                        .frame(width: gr.size.width,
                               height: lineHeight)
                        .foregroundStyle(.gray)
                    HStack(spacing: horizontalSpace) {
                        ForEach(0..<numHorizontalBlocks, id: \.self) { j in
                            Rectangle()
                                .frame(width: blockWidth, 
                                       height: blockHeight)
                        }
                    }
                    .padding(.leading, CGFloat(i) * horizontalOffset)
                }
            }
        }
    }
}

struct CafeWallView: View {
    @State var isReverse = false
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Cafewall Illusion")
                    .font(.title)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Cafewall.description")
                        .font(.caption)
                    Text("Are the horizontal lines straight?")
                        .font(.headline)
                    Text("Tap the button.")
                        .font(.subheadline)
                }
            }
            Spacer()
            CafeWallShape(isReverse: isReverse)
                .frame(height: 200)
            Spacer()
            Button("Tap") {
                withAnimation {
                    isReverse.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    CafeWallView()
        .environment(\.locale, .init(identifier: "ja"))
}
