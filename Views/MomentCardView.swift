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
    
    var body: some View {
        VStack {
            if let imageData = dateEntry.imageData, !imageData.isEmpty,
               let uiImage = UIImage(data: imageData[0]) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipped()
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
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(dateEntry.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                    
                    if !dateEntry.details.isEmpty {
                        Text(dateEntry.details)
                            .font(.body)
                            .lineLimit(2)
                    }
                }
                .padding()
                Spacer()
            }
            
        }
        .clipped()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8, y: 4)
        .frame(width: (UIScreen.main.bounds.width - 20), height: (UIScreen.main.bounds.height))
        .onLongPressGesture {
            showDeleteConfirmation = true
        }
        .confirmationDialog(
            "Delete this moment?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                modelContext.delete(dateEntry)
                try? modelContext.save()
            }
            Button("Cancel", role: .cancel) {
                showDeleteConfirmation = false
            }
        } message: {
            Text("This action cannot be undone")
        }
    }
}

#Preview {
    MomentCardView(dateEntry: DateEntry(title: "Test Title", details: "Moments of joy", date: Date()))
}
