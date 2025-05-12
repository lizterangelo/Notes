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

        // Tap the add button
        let addButton = app.buttons["addButton1"]
        XCTAssertTrue(addButton.exists, "Add buttox1n should exist")
        addButton.tap()

        // Type into the title and body fields
        let titleTextField = app.textFields["TitleTextField"]
        let bodyTextView = app.textViews["noteBodyTextView"]

        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
        XCTAssertTrue(bodyTextView.exists, "Body text view should exist")

        titleTextField.tap()
        titleTextField.typeText("thesis title")

        bodyTextView.tap()
        bodyTextView.typeText("Thesis body")

        // Dismiss the keyboard by tapping the Done button
        let doneButton = app.navigationBars.buttons["Done"]
        XCTAssertTrue(doneButton.exists, "Done button should exist")
        doneButton.tap()

        // Navigate back to the main screen
        let backButton = app.navigationBars.buttons["Notes"] // Assuming the back button title is "Notes"
        XCTAssertTrue(backButton.exists, "Back button should exist")
        backButton.tap()

        // Verify the new note appears in the table view
        let notesTable = app.tables.firstMatch
        XCTAssertTrue(notesTable.exists, "Notes table should exist")

        // Find the cell with the specific title and body
        // We can't directly query the cell by its content in this way easily.
        // Instead, we can find the cell by its title label's accessibility identifier and value.
        let newNoteTitleLabel = notesTable.staticTexts["thesis title"]
        XCTAssertTrue(newNoteTitleLabel.exists, "Note with title 'thesis title' should exist in the table")

        // Optionally, verify the body text as well, though finding the exact detailTextLabel
        // associated with the correct cell can be tricky without more specific identifiers per cell.
        // For simplicity, we'll rely on the title for now. If needed, we could add cell-specific
        // identifiers or iterate through cells.

        // A more robust check would be to find the cell containing the title and then check its subtitle.
        let cellContainingTitle = notesTable.cells.containing(.staticText, identifier: "noteCellTitleLabel").matching(identifier: "thesis title").firstMatch
        XCTAssertTrue(cellContainingTitle.exists, "Cell containing 'thesis title' should exist")

        let bodyLabelInCell = cellContainingTitle.staticTexts["noteCellBodyLabel"]
        XCTAssertTrue(bodyLabelInCell.exists, "Body label should exist in the cell")
        XCTAssertEqual(bodyLabelInCell.label, "Thesis body", "Body label should contain 'Thesis body'")
    }
}
