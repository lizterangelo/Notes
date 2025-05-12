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
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    @MainActor
    func testAddNewNote() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap the add button
        app.buttons["rectangle.stack.badge.plus"].tap()

        // Type the title
        let titleTextField = app.textFields.firstMatch
        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
        titleTextField.tap()
        titleTextField.typeText("Thesis test by lizter")

        // Type the content
        let contentTextView = app.textViews.firstMatch
        XCTAssertTrue(contentTextView.exists, "Content text view should exist")
        contentTextView.tap()
        contentTextView.typeText("this is a test")

        // Tap the done button to save
        app.navigationBars.buttons["Done"].tap()

        // Verify the app is back on the main screen
        let notesNavigationBar = app.navigationBars["Notes"]
        XCTAssertTrue(notesNavigationBar.exists, "Should be back on the Notes main screen")

        // Verify the new note appears in the table view
        let newNoteCell = app.tables.cells.staticTexts["Thesis test by lizter"]
        XCTAssertTrue(newNoteCell.exists, "New note with title 'Thesis test by lizter' should exist in the table view")
    }
}
