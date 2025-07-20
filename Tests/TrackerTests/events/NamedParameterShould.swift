import XCTest
@testable import Tracker

final class NamedParameterShould: XCTestCase {
    func testInitializeWithKeyAndValue() {
        let parameter = NamedParameter(key: "user_type", value: "premium")
        
        XCTAssertEqual(parameter.key, "user_type")
        XCTAssertEqual(parameter.value, "premium")
    }
}
