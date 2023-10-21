//
//  ZollnerView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/21.
//

import SwiftUI

struct ZollnerShapeView: View {
    @Binding var sliderValue: Float
    
    var degree2: CGFloat {
        // 90 - 150
        90 + CGFloat(sliderValue) * 90
    }
    
    var degree1: CGFloat {
        // 30 - 90
        90 - CGFloat(sliderValue) * 90
    }
    
    let strokeWidth: CGFloat = 3
    let strokeLength: CGFloat = 60
    let numLines: Int = 6
    let numVLines: Int = 16
    let lineSpace: CGFloat = 50
    let lineVSpace: CGFloat = 20
    
    @ViewBuilder
    func fragment(_ gr: GeometryProxy, isReverse: Bool) -> some View {
        var degree: CGFloat { isReverse ? degree1 : degree2 }
        
        ZStack {
            Rectangle()
                .rotationEffect(Angle(degrees: 0))
                .position(x: gr.size.width * 0.5, y: 0)
                .frame(height: strokeWidth)
            ForEach(0..<numVLines, id: \.self) { index in
                HStack(spacing: 0) {
                    Rectangle()
                        .rotationEffect(Angle(degrees: degree))
                        .position(.init(x: -gr.size.width * 0.38, y: 0))
                        .offset(x: CGFloat(index) * lineVSpace)
                        .frame(width: strokeLength, height: strokeWidth)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { gr in
                var center: CGPoint {
                    .init(x: gr.size.width * 0.5,
                          y: gr.size.height * 0.5)
                }
                ForEach(0..<numLines, id: \.self) { i in
                    fragment(gr, isReverse: i % 2 == 0)
                        .offset(y: CGFloat(i) * lineSpace)
                }
                
            }
        }
    }
}

struct ZollnerView: View {
    @State var sliderValue: Float = 0.7
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Zollner.description")
                        .font(.caption)
                    Text("Are the horizontal lines straight?")
                        .font(.headline)
                    Text("Use the slider to change the slope of the vertical line.")
                        .font(.subheadline)
                }
            }
            Spacer()
            ZollnerShapeView(sliderValue: $sliderValue)
                .frame(width: 320, height: 300)
            Spacer()
            Slider(value: $sliderValue)
        }
        .padding(.horizontal, 24)
        .navigationTitle("Zollner.title")
    }
}

#Preview {
    ZollnerView()
}
