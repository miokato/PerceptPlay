//
//  MullerLyerView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/20.
//

import SwiftUI

struct MullerLyerView: View {
    @State var isShape1Inverse = false
    @State var isShape2Inverse = true
    @State var shape1Pos: CGPoint = .zero
    @State var shape2Pos: CGPoint = .zero
    
    /// ミュラーリヤー図形1
    var shape1: some View {
        MullerLyerShape(value: isShape1Inverse ? 1.0 : 0.0)
            .stroke()
            .contentShape(Rectangle())
            .frame(width: 240, height: 80)
    }
    
    /// ミュラーリヤー図形2
    var shape2: some View {
        MullerLyerShape(value: isShape2Inverse ? 1.0 : 0.0)
            .stroke()
            .contentShape(Rectangle())
            .frame(width: 240, height: 80)
    }
    
    /// 図形
    var shapes: some View {
        GeometryReader { gr in
            shape1
                .onAppear {
                    shape1Pos = .init(x: gr.size.width * 0.5, y: gr.size.height * 0.5 - 60)
                }
                .position(shape1Pos)
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                    shape1Pos = value.location
                }))
            shape2
                .onAppear {
                    shape2Pos = .init(x: gr.size.width * 0.5, y: gr.size.height * 0.5 + 60)
                }
                .position(shape2Pos)
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                    shape2Pos = value.location
                }))
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("MullerLyer.description")
                        .font(.caption)
                    Text("Which is longer?")
                        .font(.headline)
                    Text("Let's touch and move the figure!")
                        .font(.subheadline)
                    Text("Let's superimpose figures.")
                        .font(.subheadline)
                }
            }
            .padding(.top, 10)
            shapes
                .frame(height: 200)
            Spacer()
            Button("タップ！") {
                withAnimation {
                    isShape1Inverse.toggle()
                    isShape2Inverse.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 24)
        .navigationTitle("MullerLyer.title")
    }
}

#Preview {
    MullerLyerView()
        .environment(\.locale, .init(identifier: "ja"))
}

struct MullerLyerShape: Shape {
    var value: CGFloat = 0.0
    
    var angle: CGFloat {
        100 * value
    }
    
    var animatableData: CGFloat {
        get { value }
        set { value = newValue }
    }
    
    func rotation(from point: CGPoint, center: CGPoint, degree: CGFloat, radius: CGFloat) -> CGPoint {
        let radian: CGFloat = Angle(degrees: degree).radians
        let relativeX = point.x - center.x
        let relativeY = point.y - center.y
        let x: CGFloat = (relativeX * cos(radian) - relativeY * sin(radian)) * radius
        let y: CGFloat = (relativeX * sin(radian) + relativeY * cos(radian)) * radius
        
        return .init(x: x + center.x, y: y + center.y)
    }
    
    func path(in rect: CGRect) -> Path {
        .init { path in
            var lengthX: CGFloat {
                rect.maxX - rect.minX
            }
            path.move(to: .init(x: rect.midX * 0.4, y: rect.midY))
            path.addLine(to: rotation(from: .init(x: rect.minX, y: rect.midY),
                                      center: .init(x: rect.midX * 0.4, y: rect.midY),
                                      degree: 130 - angle,
                                      radius: 0.8))
            path.move(to: .init(x: rect.midX * 0.4, y: rect.midY))
            path.addLine(to: rotation(from: .init(x: rect.minX, y: rect.midY),
                                      center: .init(x: rect.midX * 0.4, y: rect.midY),
                                      degree: 230 + angle,
                                      radius: 0.8))
            
            path.move(to: .init(x: rect.midX * 0.4, y: rect.midY))
            path.addLine(to: .init(x: rect.maxX * 0.8, y: rect.midY))
            
            path.move(to: .init(x: rect.maxX * 0.8, y: rect.midY))
            path.addLine(to: rotation(from: .init(x: rect.maxX, y: rect.midY),
                                      center: .init(x: rect.maxX * 0.8, y: rect.midY),
                                      degree: 230 + angle,
                                      radius: 0.8))
            path.move(to: .init(x: rect.maxX * 0.8, y: rect.midY))
            path.addLine(to: rotation(from: .init(x: rect.maxX, y: rect.midY),
                                      center: .init(x: rect.maxX * 0.8, y: rect.midY),
                                      degree: 130 - angle,
                                      radius: 0.8))
        }
    }
}
