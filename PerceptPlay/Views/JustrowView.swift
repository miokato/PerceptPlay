//
//  JustrowView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/21.
//

import SwiftUI

struct JustrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        .init { path in
            var leftTopPt: CGPoint {
                .init(x: rect.minX, y: rect.maxY * 0.5)
            }
            
            var leftBottomPt: CGPoint {
                .init(x: rect.maxX * 0.1, y: rect.maxY * 0.95)
            }
            
            var rightTopPt: CGPoint {
                .init(x: rect.maxX, y: rect.maxY * 0.5)
            }
            
            var rightBottomPt: CGPoint {
                .init(x: rect.maxX * 0.9, y: rect.maxY * 0.95)
            }
            
            var topCtrlPt: CGPoint {
                .init(x: rect.midX, y: rect.minY)
            }
            
            var bottomCtrlPt: CGPoint {
                .init(x: rect.midX, y: rect.maxY * 0.5)
            }
            
            // Above
            path.move(to: leftTopPt)
            path.addLine(to: leftBottomPt)
            path.move(to: leftTopPt)
            path.addQuadCurve(to: rightTopPt,
                              control: topCtrlPt)
            
            // Below
            path.move(to: rightBottomPt)
            path.addLine(to: rightTopPt)
            path.move(to: leftBottomPt)
            path.addQuadCurve(to: rightBottomPt,
                              control: bottomCtrlPt)
        }
    }
}

struct JustrowView: View {
    @State var shape1Pos: CGPoint = .zero
    @State var shape2Pos: CGPoint = .zero
    
    @ViewBuilder
    func shapes(gr: GeometryProxy) -> some View {
        ZStack {
            ZStack {
                JustrowShape()
                    .stroke(lineWidth: 5)
                    .contentShape(Rectangle())
                    .frame(width: 280, height: 140)
                Text("A")
                    .font(.title)
            }
            .onAppear {
                shape1Pos = .init(x: gr.size.width * 0.4, y: gr.size.height * 0.1)
            }
            .position(shape1Pos)
            .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                shape1Pos = value.location
            }))
            ZStack {
                JustrowShape()
                    .stroke(lineWidth: 5)
                    .contentShape(Rectangle())
                    .frame(width: 280, height: 140)
                Text("B")
                    .font(.title)
            }
            .onAppear {
                shape2Pos = .init(x: gr.size.width * 0.5, y: gr.size.height * 0.25)
            }
            .position(shape2Pos)
            .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                shape2Pos = value.location
            }))
        }
    }
    
    var body: some View {
        GeometryReader { gr in
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Justrow.description")
                            .font(.caption)
                        Text("Which figure is larger, figure A or figure B?")
                            .font(.headline)
                        Text("Let's move the figure.")
                            .font(.subheadline)
                    }
                }
                Spacer()
                shapes(gr: gr)
                    .frame(height: 300)
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    JustrowView()
}