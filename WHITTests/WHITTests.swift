//
//  WHITTests.swift
//  WHITTests
//
//  Created by Marcus Lair on 11/27/24.
//

import Testing
@testable import WHIT
import Foundation
import SwiftData

struct WHITTests {
    @Suite("Model Tests")
    struct ModelTests {
        var container: ModelContainer!
        var context: ModelContext!
        
        init() async throws {
            try await setUp()
        }

        @MainActor mutating func setUp() throws {
            
            container = try ModelContainer(for: DateEntry.self)
            try container.erase()
            context = container.mainContext
        }

        @MainActor mutating func tearDown() throws {
            container = nil
            context = nil
        }
        

        @Test("Create new date entry")
        func testCreateDateEntry() throws {
            // Given
            let title = "Test Event"
            let details = "Test Details"
            let date = Date()

            // When
            let entry = DateEntry(title: title, details: details, date: date)
            context.insert(entry)

            // Then
            let entries = try context.fetch(FetchDescriptor<DateEntry>())
            #expect(entries.count == 1)
            guard let firstEntry = entries.first else {
                #expect(Bool(false), "No entries found")
                return
            }
            #expect(firstEntry.title == title)
            #expect(firstEntry.details == details)
            #expect(firstEntry.date == date)
            #expect(firstEntry.id != nil)
        }

        @Test("Verify unique ID constraint")
        func testUniqueIDConstraint() throws {
            // Given
            let entry1 = DateEntry(title: "Event 1", details: "Details 1", date: Date())
            let entry2 = DateEntry(title: "Event 2", details: "Details 2", date: Date())

            // When
            context.insert(entry1)
            context.insert(entry2)

            // Then
            let entries = try context.fetch(FetchDescriptor<DateEntry>())
            #expect(entries.count == 2)
            #expect(entries[0].id != entries[1].id)
        }

        @Test("Update existing date entry")
        func testUpdateDateEntry() throws {
            // Given
            let entry = DateEntry(title: "Original", details: "Original Details", date: Date())
            context.insert(entry)

            // When
            entry.title = "Updated"

            // Then
            let entries = try context.fetch(FetchDescriptor<DateEntry>())
            #expect(entries.first?.title == "Updated")
        }

        @Test("Delete date entry")
        func testDeleteDateEntry() throws {
            // Given
            let entry = DateEntry(title: "To Delete", details: "Details", date: Date())
            context.insert(entry)

            // When
            context.delete(entry)

            // Then
            let entries = try context.fetch(FetchDescriptor<DateEntry>())
            #expect(entries.isEmpty)
        }

        @Test("Handle image data array")
        func testImageDataArray() throws {
            // Given
            let entry = DateEntry(title: "With Image", details: "Details", date: Date())
            let testImageData = "test".data(using: .utf8)!

            // When
            entry.imageData = [testImageData]
            context.insert(entry)

            // Then
            let entries = try context.fetch(FetchDescriptor<DateEntry>())
            #expect(entries.first?.imageData?.first == testImageData)
        }
    }

    @Suite("App Tests")
    struct AppTests {
        @Test("Initialize app with valid container")
        func testAppInitialization() throws {
            let app = WHITApp()
            #expect(!app.container.configurations.isEmpty)
        }

        @Test("Check initial onboarding state")
        func testOnboardingState() {
            // Reset onboarding state
            UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")

            let app = WHITApp()
            #expect(!app.hasSeenOnboarding)
        }
    }
}




