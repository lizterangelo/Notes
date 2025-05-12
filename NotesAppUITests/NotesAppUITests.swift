import XCTest

class NotesAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNote() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Tap the add note button
        let addButton = app.buttons["notes.addNote.button"]
        XCTAssertTrue(addButton.exists, "Add button should exist")
        addButton.tap()

        // Type the title
        // Assuming the title text field has the accessibility identifier "notes.editTitle.textfield"
        let titleTextField = app.textFields["notes.editTitle.textfield"]
        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
        titleTextField.tap() // Tap to activate the text field
        titleTextField.typeText("Thesis test by lizter")

        // Type the body content
        // Assuming the body text view has the accessibility identifier "notes.editBody.textview"
        let bodyTextView = app.textViews["notes.editBody.textview"]
        XCTAssertTrue(bodyTextView.exists, "Body text view should exist")
        bodyTextView.tap() // Tap to activate the text view
        bodyTextView.typeText("this is a test")

        // Tap the done button to save and go back
        let doneButton = app.buttons["notes.finishEditing.button"]
        XCTAssertTrue(doneButton.exists, "Done button should exist")
        doneButton.tap()

        // Verify the new note appears in the table view
        // Assuming the table view has the accessibility identifier "notes.notesList.tableview"
        let notesTable = app.tables["notes.notesList.tableview"]
        XCTAssertTrue(notesTable.exists, "Notes table view should exist")

        // Check if a cell with the new title exists
        // Note: Finding a cell by title might be brittle if multiple notes have the same title.
        // A more robust approach might involve checking the first cell if we know it's the most recent.
        // For this test, we'll check for a static text element within the table that matches the title.
        let newNoteTitle = notesTable.staticTexts["Thesis test by lizter"]
        XCTAssertTrue(newNoteTitle.waitForExistence(timeout: 5), "New note with title 'Thesis test by lizter' should appear in the list")

        // Optionally, check the subtitle (content preview) as well
        // This assumes the detailTextLabel in NoteCell shows the content preview
        let newNoteContentPreview = notesTable.staticTexts["this is a test"]
         XCTAssertTrue(newNoteContentPreview.exists, "New note with content preview 'this is a test' should appear in the list")
    }

    // Add other UI test methods here...
}
