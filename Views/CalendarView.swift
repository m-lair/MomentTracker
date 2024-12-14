import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAddEntryButton: Bool = false
    
    @Query private var entries: [DateEntry]
    @State private var selectedDate: Date?
    @State private var showingEntryDetail = false
    @State private var selectedEntry: DateEntry?
    @State private var currentMonth: Date = Date()
    
    private let screenWidth = UIScreen.main.bounds.width
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        ZStack {
            MeshGradientView(baseColor: .teal)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Button("Schedule or Add Entry") {
                    
                }
                .fontWeight(.bold)
                .frame(width: screenWidth, height: 50)
                .buttonStyle(.bordered)
                .padding()
                
                HStack {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text(monthYearString(from: currentMonth))
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
                .padding(.horizontal)
                
                // Days of week header
                LazyVGrid(columns: columns) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                }
                .padding([.leading, .trailing])
                
                
                // Calendar grid
                LazyVGrid(columns: columns) {
                    ForEach(daysInMonth(), id: \.self) { date in
                        DayCell(
                            date: date,
                            entries: entriesForDate(date),
                            isSelected: selectedDate == date
                        )
                        .onTapGesture {
                            selectedDate = date
                            if let entry = entriesForDate(date).first {
                                selectedEntry = entry
                                showingEntryDetail = true
                            }
                        }
                    }
                }
                .padding([.leading, .trailing])
                Spacer()
            }
        }
        .sheet(isPresented: $showingEntryDetail) {
            if let entry = selectedEntry {
                DateDetailView(dateEntry: entry)
            }
        }
    }
    
    private func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            withAnimation {
                currentMonth = newDate
            }
        }
    }
    
    private func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            withAnimation {
                currentMonth = newDate
            }
        }
    }
    
    private func daysInMonth() -> [Date] {
        let calendar = Calendar.current
        
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end) else {
            return []
        }
        
        let interval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        
        var dates: [Date] = []
        calendar.enumerateDates(
            startingAfter: interval.start,
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
    
    private func entriesForDate(_ date: Date) -> [DateEntry] {
        entries.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct DayCell: View {
    let date: Date
    let entries: [DateEntry]
    let isSelected: Bool
    
    private let calendar = Calendar.current
    
    var body: some View {
        VStack {
            Text("\(calendar.component(.day, from: date))")
                .font(.system(size: 16))
            
            if !entries.isEmpty {
                Circle()
                    .fill(.blue)
                    .frame(width: 6, height: 6)
            }
        }
        .padding(5)
        .frame(height: 40)
        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1)
        )
    }
}
