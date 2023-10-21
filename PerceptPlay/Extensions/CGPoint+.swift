//
//  CGFloat+.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/21.
//

import Foundation

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

