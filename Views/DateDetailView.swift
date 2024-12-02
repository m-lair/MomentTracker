//
//  DateDetailView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//


// DateDetailView.swift
import SwiftUI

struct DateDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let dateEntry: DateEntry
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                Label("Chicago, IL", systemImage: "mappin.and.ellipse")
                    .font(.title)
                Text(dateEntry.date, style: .date)
                    .foregroundColor(.gray)
            }
            .listRowBackground(Color.white.opacity(0.5))
            
            Section(header: Text("Notes")) {
                Text(dateEntry.details)
            }
            .listRowBackground(Color.white.opacity(0.5))
            
            if let imageData = dateEntry.imageData, !imageData.isEmpty {
                Section(header: Text("Photos")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(imageData, id: \.self) { data in
                                if let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .frame(width: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 3)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .listRowBackground(Color.white.opacity(0.5))
            }
        }
        .background(MeshGradientView(baseColor: .white))
        .scrollContentBackground(.hidden)
        .navigationTitle(dateEntry.title)
    }
}
