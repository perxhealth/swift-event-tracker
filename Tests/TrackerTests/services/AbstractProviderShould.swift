@testable import Tracker
import TrackerTesting
import XCTest

final class AbstractProviderShould: XCTestCase {
    func testStartEnabled() throws {
        let sut = AbstractProvider()

        try AssertFalse(sut.trackingDisabled)
    }

    func testAssignFallbackUserIdPropertyKey() {
        let sut = AbstractProvider(userIdPropertyKey: "user id property key")

        XCTAssertEqual(sut.userIdPropertyKey, "user id property key")
    }

    func testDisableTracking() throws {
        let sut = AbstractProvider()
        sut.disableTracking(true)

        try AssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() throws {
        let sut = AbstractProvider()
        sut.disableTracking(false)

        try AssertFalse(sut.trackingDisabled)
    }
}
