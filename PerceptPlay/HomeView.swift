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
            return "MullerLyer.title"
        case .ebbinghaus:
            return "Ebbinghaus.title"
        case .fick:
            return "Fick.title"
        case .cafewall:
            return "Cafewall.title"
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
            .navigationTitle("PerceptPlay")
        }
    }
}

#Preview {
    HomeView()
        .environment(\.locale, .init(identifier: "ja"))
}
