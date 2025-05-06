//
//  NotesTest.swift
//  NotesTest
//
//  Created by lizz on 4/23/25.
//

import XCTest

final class NotesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAddNewNote() throws {
        let app = XCUIApplication()
        app.launch()

        // 1. Tap the add button
        let addButton = app.buttons["notes.addNote.button"] // Use new identifier
        XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Add button should exist")
        addButton.tap()

        // 2. Find the title text field and type "Thesis Test"
        let titleTextField = app.textFields["notes.editTitle.textfield"] // Use new identifier
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title text field should exist")
        titleTextField.tap()
        titleTextField.typeText("Thesis Test")

        // 3. Find the body text view and type "Hello World"
        let bodyTextView = app.textViews["notes.editBody.textview"] // Use new identifier
        XCTAssertTrue(bodyTextView.waitForExistence(timeout: 5), "Body text view should exist")
        bodyTextView.tap()
        bodyTextView.typeText("Hello World")

        // 4. Tap the Done button (optional, dismisses keyboard)
        let doneButton = app.buttons["notes.finishEditing.button"] // Use new identifier
         if doneButton.exists {
             doneButton.tap()
         }

        // 5. Tap the back button
        // The back button's identifier is usually the title of the previous screen ("Notes" in this case)
        // Or we can access it by position.
        let backButton = app.navigationBars.buttons.element(boundBy: 0) // Assumes it's the first button
        XCTAssertTrue(backButton.waitForExistence(timeout: 5), "Back button should exist")
        backButton.tap()

        // 6. Verify that a cell with the title "Thesis Test" exists in the main view's table
        let notesTable = app.tables["notes.notesList.tableview"] // Use new identifier
        XCTAssertTrue(notesTable.waitForExistence(timeout: 5), "Notes table should exist")

        // Check for a static text element within the table that matches the title
        // Note: The cell's internal label identifiers were also renamed, but finding the cell
        // by the title text itself is usually sufficient and less brittle in UI tests.
        // If needed, you could access the specific label like:
        // let newNoteCellTitleLabel = notesTable.cells.containing(.staticText, identifier:"Thesis Test").staticTexts["notes.noteCell.<ID>.titleLabel"]
        let newNoteCellTitle = notesTable.staticTexts["Thesis Test"]
        XCTAssertTrue(newNoteCellTitle.waitForExistence(timeout: 5), "Newly added note with title 'Thesis Test' should exist in the table")
    }

    @MainActor
    func testSearchNote() throws {
        let app = XCUIApplication()
        app.launch()

        // 1. Tap the add button
        let addButton = app.buttons["notes.addNote.button"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Add button should exist")
        addButton.tap()

        // 2. Find the title text field and type "Search Test Note"
        let titleTextField = app.textFields["notes.editTitle.textfield"]
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title text field should exist")
        titleTextField.tap()
        let noteTitle = "Search Test Note \(UUID().uuidString)" // Unique title
        titleTextField.typeText(noteTitle)

        // 3. Find the body text view and type "This note is for testing search."
        let bodyTextView = app.textViews["notes.editBody.textview"]
        XCTAssertTrue(bodyTextView.waitForExistence(timeout: 5), "Body text view should exist")
        bodyTextView.tap()
        bodyTextView.typeText("This note is for testing search.")

        // 4. Tap the Done button (optional, dismisses keyboard)
        let doneButton = app.buttons["notes.finishEditing.button"]
         if doneButton.exists {
             doneButton.tap()
         }

        // 5. Tap the back button
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.waitForExistence(timeout: 5), "Back button should exist")
        backButton.tap()

        // 6. Tap the search bar and type the note title
        let searchBar = app.searchFields["notes.searchNotes.searchbar"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), "Search bar should exist")
        searchBar.tap()
        searchBar.typeText(noteTitle)

        // 7. Verify that the note with the title "Search Test Note" exists in the table
        let notesTable = app.tables["notes.notesList.tableview"]
        XCTAssertTrue(notesTable.waitForExistence(timeout: 5), "Notes table should exist")
        
        let searchedNoteCellTitle = notesTable.staticTexts[noteTitle]
        XCTAssertTrue(searchedNoteCellTitle.waitForExistence(timeout: 10), "Searched note with title '\(noteTitle)' should exist in the table")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
