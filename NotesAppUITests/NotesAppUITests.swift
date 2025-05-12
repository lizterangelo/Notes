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

    @MainActor
    func testAddNewNote() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap the add button (assuming it's the first button found)
        // A more robust test would use an accessibility identifier
        let addButton = app.buttons.firstMatch
        XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Add button should exist")
        addButton.tap()

        // Find and type into the title text field
        // A more robust test would use an accessibility identifier
        let titleTextField = app.textFields.firstMatch
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title text field should exist")
        titleTextField.tap()
        titleTextField.typeText("Thesis test by lizter")

        // Find and type into the content text view
        // A more robust test would use an accessibility identifier
        let contentTextView = app.textViews.firstMatch
        XCTAssertTrue(contentTextView.waitForExistence(timeout: 5), "Content text view should exist")
        contentTextView.tap()
        contentTextView.typeText("this is a test")

        // Tap the Done button
        let doneButton = app.navigationBars.buttons["Done"]
        XCTAssertTrue(doneButton.waitForExistence(timeout: 5), "Done button should exist")
        doneButton.tap()

        // Verify the new note appears in the table view
        let newNoteTitle = app.tables.staticTexts["Thesis test by lizter"]
        XCTAssertTrue(newNoteTitle.waitForExistence(timeout: 5), "New note with title 'Thesis test by lizter' should appear in the list")
    }
}
