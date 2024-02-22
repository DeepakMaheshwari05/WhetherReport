//
//  WhetherReportUITests.swift
//  WhetherReportUITests
//
//  Created by deepakmaheshwari on 20/02/24.
//

import XCTest

final class WhetherReportUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testUI() {
        let app = XCUIApplication()
        app.launch()

        let cityLabel = app.staticTexts["cityLabel"]
        let datelabel = app.staticTexts["datelabel"]

        XCTAssert(!cityLabel.label.isEmpty)
        XCTAssert(!datelabel.label.isEmpty)

        XCTAssertEqual(cityLabel.label, "City")
        XCTAssertEqual(datelabel.label, "date")
        
        let actionButton = app.buttons["actionButton"]

        XCTAssertEqual(actionButton.label, "Action")

    }

}
