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
    case zollner
    case justrow
    case hermannGrid
    
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
        case .zollner:
            return "Zollner.title"
        case .justrow:
            return "Justrow.title"
        case .hermannGrid:
            return "HermannGrid.title"
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(OpticalIllusionType.allCases, id: \.self) { illustionType in
                        NavigationLink(illustionType.title, value: illustionType)
                    }
                } header: {
                    Text("Visual Illusion")
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
                case .zollner:
                    ZollnerView()
                case .justrow:
                    JustrowView()
                case .hermannGrid:
                    HermannGridView()
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
