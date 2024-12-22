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
    @Query(sort: \DateEntry.date, order: .forward) private var dates: [DateEntry]
    @State private var showingAddDate = false
    
    let cardWidth = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top) {
                    ForEach(dates) { moment in
                        VStack {
                            NavigationLink(value: moment) {
                                MomentCardView(dateEntry: moment)
                                    .frame(width: cardWidth)
                                    .scrollTransition(axis: .horizontal) { content, phase in
                                        content
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.95)
                                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                                    }
                            }
                            Text(moment.details)
                                .font(.body)
                                .frame(width: cardWidth)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.95)
                                        .opacity(phase.isIdentity ? 1.0 : 0.0)
                                }
                                
                        }
                    }
                }
            }
            
            .contentMargins(.horizontal, 10)
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
}
