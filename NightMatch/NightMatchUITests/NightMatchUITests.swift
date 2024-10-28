//
//  NightMatchUITests.swift
//  NightMatchUITests
//
//  Created by Yu, Jack on 2024/6/19.
//

import XCTest

final class NightMatchUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.buttons["num_9"]/*[[".buttons[\"9\"]",".buttons[\"num_9\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["num_0"]/*[[".buttons[\"0\"]",".buttons[\"num_0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["ok"]/*[[".buttons[\"OK\"]",".buttons[\"ok\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.staticTexts["TopView_resultView"].exists)
        XCTAssertEqual(app.staticTexts["TopView_resultView"].label, "90")
        
        printAllElements(on:app)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    /// This private method prints the debug description of all elements in the provided XCUIApplication.
    /// - Parameters:
    ///    - app: The XCUIApplication instance to inspect for elements.
    private func printAllElements(on app: XCUIApplication) {
        let element = app.otherElements.element
        debugPrint("ELEMENT - \(element.debugDescription)")
    }
}
