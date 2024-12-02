import Foundation
import SwiftData
import SwiftUI

@Model
class DateEntry: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var details: String
    var date: Date
    var imageData: [Data]?
    
    init(title: String, details: String, date: Date) {
        self.id = UUID()
        self.title = title
        self.details = details
        self.date = date
        self.imageData = []
    }
}
