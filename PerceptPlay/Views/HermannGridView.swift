//
//  HermannGridView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/22.
//

import SwiftUI

struct HermannGridShapeView: View {
    var spaceValue: Float
    var space: CGFloat {
        20 * CGFloat(spaceValue)
    }
    let numRow: Int = 5
    let numColumn: Int = 5
    var body: some View {
        Grid(horizontalSpacing: space,
             verticalSpacing: space ) {
            ForEach(0..<numRow, id: \.self) { i in
                GridRow {
                    ForEach(0..<numColumn, id: \.self) { j in
                        Rectangle()
                            .fill(.black)
                    }
                }
            }
        }
    }
}

struct HermannGridView: View {
    @State var spaceValue: Float = 0.5
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("HermannGrid.description")
                        .font(.caption)
                    Text("HermannGrid.headline")
                        .font(.headline)
                    Text("HermannGrid.subheadline")
                        .font(.subheadline)
                }
            }
            Spacer()
            HermannGridShapeView(spaceValue: spaceValue)
                .frame(width: 300, height: 300)
            Spacer()
            Slider(value: $spaceValue)
        }
        .navigationTitle("HermannGrid.title")
        .padding(.horizontal, 24)
        
    }
}

#Preview {
    HermannGridView()
}
