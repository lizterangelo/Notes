//
//  NotesAppUITests.swift
//  NotesAppUITests
//
//  Created by lizz on 5/12/25.
//

import XCTest

final class NotesAppUITests: XCTestCase {

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
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testAddNote() throws {
        let app = XCUIApplication()
        app.launch()

        // Arrange
        let addButton = app.buttons["addButton"]
        let notesTableView = app.tables["notesTableView"]
        let titleTextField = app.textFields["noteTitleTextField"]
        let contentTextView = app.textViews["noteContentTextView"]
        let doneButton = app.buttons["doneButton"]

        let noteTitle = "Thesis test by lizter"
        let noteContent = "this is a test"

        // Act
        XCTAssertTrue(addButton.exists, "Add button should exist")
        addButton.tap()

        // Wait for the NoteViewController to appear and elements to exist
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title text field should exist")
        XCTAssertTrue(contentTextView.exists, "Content text view should exist")
        XCTAssertTrue(doneButton.exists, "Done button should exist")

        titleTextField.tap()
        titleTextField.typeText(noteTitle)

        contentTextView.tap()
        contentTextView.typeText(noteContent)

        doneButton.tap()

        // Assert
        // Verify that the app is back on the main screen and the new note is visible
        XCTAssertTrue(notesTableView.waitForExistence(timeout: 5), "Notes table view should exist after saving")

        // Find the cell containing the new note's title
        let newNoteCell = notesTableView.cells.containing(.staticText, identifier: noteTitle).firstMatch
        XCTAssertTrue(newNoteCell.exists, "New note cell with title '\(noteTitle)' should exist")

        // Verify the content within the found cell
        let noteContentLabel = newNoteCell.staticTexts["noteContentLabel"]
        XCTAssertTrue(noteContentLabel.exists, "Note content label should exist in the cell")
        XCTAssertEqual(noteContentLabel.label, noteContent, "Note content should match the entered text")

        // Optional: Clean up the created note if needed for test independence
        // This would involve finding the cell and swiping to delete, but let's keep it simple for now.
    }
}
