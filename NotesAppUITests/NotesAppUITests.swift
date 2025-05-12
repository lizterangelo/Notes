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
    func testAddNote() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap the add button (assuming it has an accessibility label or can be found by image)
        // The system image "rectangle.stack.badge.plus" might translate to an accessibility label like "Add"
        let addButton = app.buttons["Add"] // Or find by image if label doesn't work
        XCTAssertTrue(addButton.exists, "Add button should exist")
        addButton.tap()

        // Enter title
        let titleTextField = app.textFields.firstMatch // Assuming the first text field is the title
        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
        titleTextField.tap()
        titleTextField.typeText("Lizter thesis test")

        // Enter content
        let contentTextView = app.textViews.firstMatch // Assuming the first text view is the content
        XCTAssertTrue(contentTextView.exists, "Content text view should exist")
        contentTextView.tap()
        contentTextView.typeText("Thesis test test")

        // Tap the Done button
        let doneButton = app.navigationBars.buttons["Done"]
        XCTAssertTrue(doneButton.exists, "Done button should exist")
        doneButton.tap()

        // Verify the note appears in the table view
        let notesTable = app.tables.firstMatch
        XCTAssertTrue(notesTable.exists, "Notes table should exist")

        let newNoteCell = notesTable.cells.containing(.staticText, identifier: "Lizter thesis test").firstMatch
        XCTAssertTrue(newNoteCell.exists, "New note cell with title 'Lizter thesis test' should exist")

        let contentLabel = newNoteCell.staticTexts["Thesis test test"]
        XCTAssertTrue(contentLabel.exists, "New note cell should contain content 'Thesis test test'")

        // Verify we are back on the main screen (e.g., check for the navigation bar title)
        let mainScreenTitle = app.navigationBars["Notes"].firstMatch
        XCTAssertTrue(mainScreenTitle.exists, "Should be back on the main 'Notes' screen")
    }
}
