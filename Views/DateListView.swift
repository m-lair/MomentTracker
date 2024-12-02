//
//  DateListView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//

import SwiftUI
import SwiftData

struct DateListView: View {
    @Environment(\.modelContext) private var modelContext
    @Namespace private var namespace
    var screenWidth = UIScreen.main.bounds.width
    @Query(sort: \DateEntry.date, order: .forward) private var dates: [DateEntry]
    @State private var showingAddDate = false
    @State private var triggerHaptic = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(dates) { moment in
                    NavigationLink(value: moment) {
                        MomentCardView(dateEntry: moment)
                            .scrollTransition(axis: .horizontal) { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.95)
                                    .opacity(phase.isIdentity ? 1.0 : 0.8)
                            }
                    }
                }
            }
        }
        .contentMargins(10)
        .scrollTargetBehavior(.paging)
        .navigationDestination(for: DateEntry.self) { dateEntry in
            DateDetailView(dateEntry: dateEntry)
                
        }
        
        .navigationTitle("Moment Tracker")
        .toolbar {
            Button(action: { showingAddDate = true }) {
                Image(systemName: "plus")
                    .bold()
            }
        }
        .sheet(isPresented: $showingAddDate) {
            NavigationStack {
                AddDateView()
                    .scrollContentBackground(.hidden)
                    .presentationBackground(.thinMaterial)
            }
        }
    }
}
