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
                    VStack {
                        Text("Thank you for sharing all these moments with me. You have made me feel so many feelings in such a short time and I so am grateful for your kindness, your thoughfulness, and how much love you give. Not even just to me but to everyone around you. It feels like I could overcome anything as long as I had you by my side and I hope I can be that for you as well. I love you so much!❤️")
                        Text("-marcus")
                            .padding()
                            .padding(.leading, 100)
                    }
                    .frame(width: cardWidth)
                    .padding(.top, 100)
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
