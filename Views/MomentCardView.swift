//
//  DateRow.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//

import Foundation
import SwiftUI

struct MomentCardView: View {
    @Environment(\.modelContext) private var modelContext
    let dateEntry: DateEntry
    @State private var showDeleteConfirmation = false
    @State private var showEditConfirmation = false
    @State private var showAddConfirmation = false
    @State private var showAddImageConfirmation = false
    @State private var showAddLocationConfirmation = false
    @State private var showAddVideoConfirmation = false
    @State private var showAddAudioConfirmation = false
    @State private var showAddLinkConfirmation = false
    @State private var isShowingDeleteConfirmation = false
    @State private var isHighlighted: Bool = false
    var body: some View {
        VStack {
            if let imageData = dateEntry.imageData, !imageData.isEmpty,
               let uiImage = UIImage(data: imageData[0]) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .overlay(isHighlighted ? Color.white.opacity(0.5) : Color.clear)
            }
            else {
                Image("Sample Image 1")
                    .resizable()
                    .scaledToFit()
                    .clipped()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(dateEntry.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(dateEntry.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .padding(.leading, 5)
                }
                Spacer()
            }
        }
        .padding()
        .background(.white)
        .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 500)
        .clipped()
        .shadow(radius: 8, y: 4)
        .onLongPressGesture {
            withAnimation {
                isHighlighted = true
            }
            isShowingDeleteConfirmation = true
        }
        .confirmationDialog(
            "Delete this moment?",
            isPresented: $isShowingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button(role: .destructive) {
                modelContext.delete(dateEntry)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Button("Cancel", role: .cancel) {
                isShowingDeleteConfirmation = false
                withAnimation {
                    isHighlighted = false
                }
            }
        } message: {
            Text("This action cannot be undone")
        }
    }
}

#Preview {
    MomentCardView(dateEntry: DateEntry(title: "Test Title", details: "Moments of joy", date: Date()))
}
