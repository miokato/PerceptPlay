//
//  HomeView.swift
//  PerceptPlay
//
//  Created by mio kato on 2023/10/20.
//

import SwiftUI

enum OpticalIllusionType: CaseIterable {
    case mullerLyer
    case ebbinghaus
    case fick
    case cafewall
    
    var title: LocalizedStringKey {
        switch self {
        case .mullerLyer:
            return "MullerLyerOpticalIllusion"
        case .ebbinghaus:
            return "EbbinghausOpticalIllusion"
        case .fick:
            return "Fick illusion"
        case .cafewall:
            return "Cafewall Illusion"
        }
    }
}


struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(OpticalIllusionType.allCases, id: \.self) { illustionType in
                    NavigationLink(illustionType.title, value: illustionType)
                }
            }
            .navigationDestination(for: OpticalIllusionType.self, destination: { illusionType in
                switch illusionType {
                case .mullerLyer:
                    MullerLyerView()
                case .ebbinghaus:
                    EbbinghausView()
                case .fick:
                    FickView()
                case .cafewall:
                    CafeWallView()
                }
            })
            .navigationTitle("OpticalIllusion")
        }
    }
}

#Preview {
    HomeView()
        .environment(\.locale, .init(identifier: "ja"))
}
