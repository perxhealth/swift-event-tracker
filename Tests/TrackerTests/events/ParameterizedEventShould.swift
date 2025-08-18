import XCTest

@testable import Tracker

final class ParameterizedEventShould: XCTestCase {
    let sut = ParameterizedEvent(
        name: "some event name",
        parameters: [NamedParameter(key: "key0", value: "value0")]
    )

    func testSupportAddingParameters() {
        let event = sut + [NamedParameter(key: "key1", value: "value1")]
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, ["key0": "value0", "key1": "value1"])
        XCTAssertEqual(event.excludedTags, [])
        XCTAssertEqual(event.requiredTags, [])
    }

    func testSupportAddingRequiredTag() {
        let event = sut + .debugging
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, sut.resolvedParameters)
        XCTAssertEqual(event.excludedTags, sut.excludedTags)
        XCTAssertEqual(event.requiredTags, [.debugging])
    }

    func testSupportAddingRequiredTags() {
        let event = sut + [.analytics, .debugging]
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, sut.resolvedParameters)
        XCTAssertEqual(event.excludedTags, sut.excludedTags)
        XCTAssertEqual(event.requiredTags, [.analytics, .debugging])
    }

    func testSupportAddingExcludedTag() {
        let event = sut - .crashReporting
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, sut.resolvedParameters)
        XCTAssertEqual(event.excludedTags, [.crashReporting])
        XCTAssertEqual(event.requiredTags, [])
    }

    func testSupportAddingExcludedTags() {
        let event = sut - [.debugging, .crashReporting]
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, sut.resolvedParameters)
        XCTAssertEqual(event.excludedTags, [.debugging, .crashReporting])
        XCTAssertEqual(event.requiredTags, [])
    }
}
