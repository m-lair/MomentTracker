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
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    init() {
        do {
            container = try ModelContainer(for: DateEntry.self)
            // Check if entries exist
            let context = container.mainContext
            let fetchDescriptor = FetchDescriptor<DateEntry>()
            
            let existingEntries = try context.fetch(fetchDescriptor)
            
            if existingEntries.isEmpty {
                // No entries exist, add default data
                let seedEntries = DateEntrySeedData.defaultEntries()
                seedEntries.forEach { context.insert($0) }
            }
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
                        .background(MeshGradientView(baseColor: .white).opacity(0.5))
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                NavigationLink(destination: CalendarView()) {
                                    Image(systemName: "calendar")
                                }
                            }
                        }
                    
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
