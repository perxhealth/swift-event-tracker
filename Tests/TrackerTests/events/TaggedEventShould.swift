@testable import Tracker
import XCTest

final class TaggedEventShould: XCTestCase {
    let sut = TaggedEvent(name: "some event name",
                          parameters: [NamedParameter(key: "key0", value: "value0")],
                          excludedTags: [.crashReporting],
                          requiredTags: [.analytics])

    func testSupportAddingParameters() {
        let event = sut + [NamedParameter(key: "key1", value: "value1")]
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, ["key0": "value0", "key1": "value1"])
        XCTAssertEqual(event.requiredTags, sut.requiredTags)
        XCTAssertEqual(event.excludedTags, sut.excludedTags)
    }

    func testSupportAddingRequiredTag() {
        let event = sut + .debugging
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, sut.resolvedParameters)
        XCTAssertEqual(event.excludedTags, sut.excludedTags)
        XCTAssertEqual(event.requiredTags, [.analytics, .debugging])
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
        XCTAssertEqual(event.requiredTags, sut.requiredTags)
    }

    func testSupportAddingExcludedTags() {
        let event = sut - [.debugging, .crashReporting]
        XCTAssertEqual(event.name, sut.name)
        XCTAssertEqual(event.resolvedParameters, sut.resolvedParameters)
        XCTAssertEqual(event.excludedTags, [.crashReporting, .debugging])
        XCTAssertEqual(event.requiredTags, sut.requiredTags)
    }
}
