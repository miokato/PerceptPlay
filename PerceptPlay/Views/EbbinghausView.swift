//
//  EbbinghausView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/20.
//

import SwiftUI

struct EbbinghausShapeView: View {
    var isScaling: Bool
    
    var size: CGFloat {
        isScaling ? 18 : 56
    }
    var offset: CGFloat {
        isScaling ? -30 : -70
    }
    var numCircles: Int {
        isScaling ? 8 : 6
    }
    var spaceDegree: CGFloat {
        isScaling ? 45 : 60
    }
    var offsetDegree: CGFloat {
        45
    }
    var circles: some View {
        ForEach(0 ..< numCircles, id: \.self) { index in
            Circle()
                .foregroundStyle(.gray)
                .frame(width: size, height: size)
                .padding(offset)
                .rotationEffect(Angle(degrees: CGFloat(index) * spaceDegree - offsetDegree), anchor: .top)
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { gr in
                ZStack {
                    Circle()
                        .foregroundStyle(.orange)
                        .frame(width: 30, height: 30)
                    circles
                        .position(x: gr.size.width * 0.5,
                                  y: gr.size.height * 0.5)
                    
                }
            }
        }
    }
}

struct EbbinghausView: View {
    @State var isScaling1 = true
    @State var isScaling2 = false
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("EbbinghausOpticalIllusion")
                    .font(.title)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Ebbinghaus.description")
                        .font(.caption)
                    Text("Which is bigger?")
                        .font(.headline)
                    Text("Tap the buttons to change the size.")
                        .font(.subheadline)
                }
            }
            Spacer()
            HStack(spacing: 80) {
                EbbinghausShapeView(isScaling: isScaling1)
                    .frame(width: 100)
                EbbinghausShapeView(isScaling: isScaling2)
                    .frame(width: 100)
            }
            Spacer()
            Button("Tap") {
                withAnimation {
                    isScaling1.toggle()
                    isScaling2.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    EbbinghausView()
        .environment(\.locale, .init(identifier: "ja"))
}
