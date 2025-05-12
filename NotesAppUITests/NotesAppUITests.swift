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

        // Tap the add button
        let addButton = app.buttons["addButton"]
        XCTAssertTrue(addButton.exists, "Add button should exist")
        addButton.tap()

        // Enter title
        let titleTextField = app.textFields.element(boundBy: 0) // Assuming the first text field is the title
        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
        titleTextField.tap()
        titleTextField.typeText("Thesis test by lizter")

        // Enter content
        let contentTextView = app.textViews["noteContentTextView"]
        XCTAssertTrue(contentTextView.exists, "Content text view should exist")
        contentTextView.tap()
        contentTextView.typeText("this is a test")

        // Tap the done button
        let doneButton = app.navigationBars.buttons["Done"]
        XCTAssertTrue(doneButton.exists, "Done button should exist")
        doneButton.tap()

        // Verify the new note appears in the list
        let newNoteCell = app.tables.cells.staticTexts["Thesis test by lizter"]
        XCTAssertTrue(newNoteCell.waitForExistence(timeout: 5), "New note with title 'Thesis test by lizter' should appear in the list")
    }
}
