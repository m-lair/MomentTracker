//
//  DateDetailView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//

import SwiftUI

struct DateDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedImage: Data?
    @State private var isExpanded = false
    
    let dateEntry: DateEntry
    
    var body: some View {
        ZStack {
            MeshGradientView(baseColor: .pink)
                .opacity(0.5)
                .ignoresSafeArea()
            
            Form {
                Section(header: Text("Details")) {
                    Text(dateEntry.date, style: .date)
                }
                .listRowBackground(Color.white.opacity(0.5))
                
                Section(header: Text("Notes")) {
                    Text(dateEntry.details)
                }
                .listRowBackground(Color.white.opacity(0.5))
                
                if let imageData = dateEntry.imageData, !imageData.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(imageData, id: \.self) { data in
                                if let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 300)  // Make them bigger
                                        .background(Color.clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 3)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                        .background(Color.clear)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(dateEntry.title)
        }
    }
}
