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
    
    var title: LocalizedStringKey {
        switch self {
        case .mullerLyer:
            return "MullerLyer"
        case .ebbinghaus:
            return "Ebbinghaus"
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
