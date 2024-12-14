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


struct StickerPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var dateEntry: DateEntry
    let cardSize: CGFloat
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Long press a sticker to add it")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top)
                
                // Here you would integrate with the Messages framework
                // This is a placeholder grid of example stickers
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
                    ForEach(0..<12) { _ in
                        Image(systemName: "star.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .clipShape(Circle())
                            .onLongPressGesture {
                                addPlaceholderSticker()
                                dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Add Sticker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func addPlaceholderSticker() {
        // In a real implementation, you would use the actual sticker data
        if let stickerImage = UIImage(systemName: "star.fill"),
           let stickerData = stickerImage.pngData() {
            let centerPosition = CGPoint(x: cardSize/2, y: cardSize/2)
            let newSticker = StickerPlacement(
                stickerData: stickerData,
                position: centerPosition
            )
            dateEntry.stickers.append(newSticker)
        }
    }
}
