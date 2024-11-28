//
//  DateListView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//


// DateListView.swift
import SwiftUI
import SwiftData

struct DateListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DateEntry.date, order: .reverse) private var dates: [DateEntry]
    @Namespace private var animation
    @State private var animateGradient: Bool = false
    @State private var showingAddDate = false
    
    var body: some View {
        List {
            ForEach(dates) { dateEntry in
                NavigationLink {
                    DateDetailView(dateEntry: dateEntry)
                        .background(MeshGradientView(baseColor: .red))
                        .navigationTransition(.zoom(sourceID: "icon", in: animation))
                } label: {
                    DateRow(dateEntry: dateEntry)
                        .matchedTransitionSource(id: "icon", in: animation)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .onDelete(perform: deleteDates)
            .listRowBackground(Color.white.opacity(0.5))
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Date Tracker")
        .toolbar {
            Button(action: { showingAddDate = true }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddDate) {
            NavigationStack {
                AddDateView()
                    .scrollContentBackground(.hidden)
                    .presentationBackground(.thinMaterial)
            }
            .accentColor(.black)
        }
    }
    
    private func deleteDates(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(dates[index])
        }
    }
}
