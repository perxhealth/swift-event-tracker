@testable import Tracker
import XCTest

final class TagShould: XCTestCase {
    func testInitializeFromStringLiteral() {
        XCTAssertEqual(Tag("some tag identifier"), "some tag identifier")
    }

    func testInitializeFromStringInterpolation() {
        XCTAssertEqual(Tag("some tag identifier"), "some \("tag") identifier")
    }
}
