//
//  WHITApp.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//

import SwiftUI
import SwiftData

@main
struct WHITApp: App {
    let container: ModelContainer
    @State private var startAnimation: Bool = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    init() {
        do {
            container = try ModelContainer(for: DateEntry.self)
        } catch {
            fatalError("Failed to initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !hasSeenOnboarding {
                    OnboardingView()
                } else {
                    DateListView()
                        .background(MeshGradientView(baseColor: .blue).opacity(0.5))
                        .toolbarColorScheme(.dark, for: .navigationBar)
                }
            }
            .accentColor(.black)
        }
        .modelContainer(container)
    }
}

#Preview {
    DateListView()
}
