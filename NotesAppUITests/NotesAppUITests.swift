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

        @MainActor
        func testAddNewNote() throws {
            let app = XCUIApplication()
            app.launch()

            // Tap the add button using its accessibility identifier
            let addButton = app.buttons["addButton"]
            XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Add button should exist and be hittable")
            addButton.tap()

            // Enter title using its accessibility identifier
            let titleTextField = app.textFields["noteTitleTextField"]
            XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title text field should exist and be hittable")
            titleTextField.tap() // Tap to activate the text field
            titleTextField.typeText("Thesis test by lizter")

            // Enter content using its accessibility identifier
            let contentTextView = app.textViews["noteContentTextView"]
            XCTAssertTrue(contentTextView.waitForExistence(timeout: 5), "Content text view should exist and be hittable")
            contentTextView.tap() // Tap to activate the text view
            contentTextView.typeText("this is a test")

            // Tap the "Done" button in the navigation bar
            let doneButton = app.navigationBars.buttons["Done"]
            XCTAssertTrue(doneButton.waitForExistence(timeout: 5), "Done button should exist and be hittable")
            doneButton.tap()

            // Verify return to the main screen by checking for the "Notes" title
            let notesTitle = app.navigationBars["Notes"]
            XCTAssertTrue(notesTitle.waitForExistence(timeout: 5), "Should return to the Notes screen")

            // Optional: Add steps here to verify the new note appears in the list
            // and potentially delete it for test cleanup. This would require
            // identifying the table view and the cell for the new note.
        }
    }

    @MainActor
    func testAddNewNote() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap the add button (assuming it's the first button or identifiable)
        // A more robust test would use an accessibility identifier for the button.
        // Based on the summary, the button image is "rectangle.stack.badge.plus".
        // Let's try finding a button by its image or a generic button element.
        // If this fails, we might need to add an accessibility identifier to the AddButton class.
        let addButton = app.buttons.element(boundBy: 0) // Assuming it's the first button
        // Alternatively, try finding by image name if accessible:
        // let addButton = app.buttons["rectangle.stack.badge.plus"] // This might not work directly

        XCTAssertTrue(addButton.exists, "Add button should exist")
        addButton.tap()

        // Enter title
        // Based on the summary, the title field is a UITextField.
        // A more robust test would use an accessibility identifier for the text field.
        let titleTextField = app.textFields.element(boundBy: 0) // Assuming it's the first text field
        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
        titleTextField.tap() // Tap to activate the text field
        titleTextField.typeText("Thesis test by lizter")

        // Enter content
        // Based on the summary, the content field is a UITextView.
        // A more robust test would use an accessibility identifier for the text view.
        let contentTextView = app.textViews.element(boundBy: 0) // Assuming it's the first text view
        XCTAssertTrue(contentTextView.exists, "Content text view should exist")
        contentTextView.tap() // Tap to activate the text view
        contentTextView.typeText("this is a test")

        // Tap the "Done" button in the navigation bar
        let doneButton = app.navigationBars.buttons["Done"]
        XCTAssertTrue(doneButton.exists, "Done button should exist")
        doneButton.tap()

        // Verify return to the main screen by checking for the "Notes" title
        let notesTitle = app.navigationBars["Notes"]
        XCTAssertTrue(notesTitle.exists, "Should return to the Notes screen")

        // Optional: Add steps here to verify the new note appears in the list
        // and potentially delete it for test cleanup. This would require
        // identifying the table view and the cell for the new note.
    }
}
