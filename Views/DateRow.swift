//
//  DateRow.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//

import Foundation
import SwiftUI

struct DateRow: View {
    let dateEntry: DateEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dateEntry.title)
                    .font(.headline)
                    .opacity(0.9)
                Text(dateEntry.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            if let imageData = dateEntry.imageData, !imageData.isEmpty {
                if let uiImage = UIImage(data: imageData[0]) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
