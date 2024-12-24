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
        ZStack {
            // The white "Polaroid" background
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 8, y: 4)
            
            VStack {
                // The image section
                Group {
                    if let imageData = dateEntry.imageData,
                       !imageData.isEmpty,
                       let uiImage = UIImage(data: imageData[0]) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .overlay(isHighlighted ? Color.white.opacity(0.5) : Color.clear)
                            .clipped()
                    } else {
                        Image("Sample Image 1")
                            .resizable()
                            .scaledToFit()
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 12))
                            .clipped()
                    }
                }
                
                // Title and date
                HStack {
                    VStack(alignment: .leading) {
                        Text(dateEntry.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        Text(dateEntry.date.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                            .padding(.leading, 5)
                    }
                    Spacer()
                    Label("\(dateEntry.imageData?.count ?? 0)", systemImage: "photo")
                }
                .padding([.leading, .top], 5)
            }
            .padding()
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 40, maxHeight: 500) // Adjust if you want more/less width
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
                do {
                    try modelContext.save()
                } catch {
                    print("error deleting")
                }
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
