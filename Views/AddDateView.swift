//
//  AddDateView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//


// AddDateView.swift
import SwiftUI
import SwiftData
import PhotosUI


struct AddDateView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var details = ""
    @State private var date = Date()
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []
    
    var body: some View {
        Form {
            Section(header: Text("Date Details")) {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $date)
            }
            .foregroundStyle(.black)
            .listRowBackground(Color.white.opacity(0.5))
            
            Section(header: Text("Notes")) {
                TextEditor(text: $details)
                    .frame(height: 100)
            }
            .foregroundStyle(.black)
            .listRowBackground(Color.white.opacity(0.5))
            
            Section {
                PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 3, matching: .images) {
                    Label(!selectedPhotos.isEmpty ? "Change Photos" : "Select a photo" , systemImage: "photo")
                }
                .scrollContentBackground(.hidden)
                .onChange(of: selectedPhotos) {
                    loadSelectedPhotos()
                }
                
                if !selectedPhotos.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(images, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)  // Fixed height for consistency
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 3)   // Optional: adds subtle shadow
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                }
            }
            .foregroundStyle(.black)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.white.opacity(0.5))
        }
        .colorScheme(.light)
        .navigationTitle("Add New Date")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveDate()
                }
                .disabled(title.isEmpty)  // Prevents saving without a title
            }
        }
    }
    
    private func saveDate() {
        let imageData = images.compactMap { $0.jpegData(compressionQuality: 0.7) }
        let newDate = DateEntry(title: title, details: details, date: date)
        newDate.imageData = imageData
        modelContext.insert(newDate)
        dismiss()
    }
    
    private func loadSelectedPhotos() {
        images.removeAll()
        Task {
            await withTaskGroup(of: (UIImage?, Error?).self) { taskGroup in
                for photoItem in selectedPhotos {
                    taskGroup.addTask {
                        do {
                            if let imageData = try await photoItem.loadTransferable(type: Data.self),
                               let image = UIImage(data: imageData) {
                                return (image, nil)
                            }
                            return (nil, nil)
                        } catch {
                            return (nil, error)
                        }
                    }
                }
                
                for await result in taskGroup {
                    if result.1 != nil {
                        break
                    } else if let image = result.0 {
                        images.append(image)
                    }
                }
            }
        }
    }
}
