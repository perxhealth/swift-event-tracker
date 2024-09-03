@testable import Tracker
import TrackerTesting
import XCTest

final class ServiceShould: XCTestCase {
    public class Sut: Service {
        public init() {}
        public var supportedTags: [Tag] = []
        public var trackingDisabled: Bool {
            get { return underlyingTrackingDisabled }
            set(value) { underlyingTrackingDisabled = value }
        }
        public var underlyingTrackingDisabled: (Bool)!


        //MARK: - trackEvent

        public var trackEventEventEventVoidCallsCount = 0
        public var trackEventEventEventVoidCalled: Bool {
            return trackEventEventEventVoidCallsCount > 0
        }
        public var trackEventEventEventVoidReceivedEvent: (Event)?
        public var trackEventEventEventVoidReceivedInvocations: [(Event)] = []
        public var trackEventEventEventVoidClosure: ((Event) -> Void)?

        public func trackEvent(_ event: Event) {
            trackEventEventEventVoidCallsCount += 1
            trackEventEventEventVoidReceivedEvent = event
            trackEventEventEventVoidReceivedInvocations.append(event)
            trackEventEventEventVoidClosure?(event)
        }

        //MARK: - disableTracking

        public var disableTrackingFlagBoolVoidCallsCount = 0
        public var disableTrackingFlagBoolVoidCalled: Bool {
            return disableTrackingFlagBoolVoidCallsCount > 0
        }
        public var disableTrackingFlagBoolVoidReceivedFlag: (Bool)?
        public var disableTrackingFlagBoolVoidReceivedInvocations: [(Bool)] = []
        public var disableTrackingFlagBoolVoidClosure: ((Bool) -> Void)?

        public func disableTracking(_ flag: Bool) {
            disableTrackingFlagBoolVoidCallsCount += 1
            disableTrackingFlagBoolVoidReceivedFlag = flag
            disableTrackingFlagBoolVoidReceivedInvocations.append(flag)
            disableTrackingFlagBoolVoidClosure?(flag)
        }
    }

    func testTrackEvent() {
        let sut = Sut()
        sut.trackEvent(NamedEvent("some event"))
        XCTAssertEqual(sut.trackEventEventEventVoidCallsCount, 1)
    }

    func testTrackScreen() {
        let sut = Sut()
        let screen = ScreenMock()
        screen.name = "some screen name"
        sut.trackScreen(screen)
        XCTAssertEqual(sut.trackEventEventEventVoidCallsCount, 1)
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.name, "some screen name viewed")
    }

    func testSetUserId() {
        let sut = Sut()
        sut.setUserId("some user id")
        XCTAssertEqual(sut.trackEventEventEventVoidCallsCount, 1)
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.name, "Set user")
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.parameters, ["user-id": "some user id"])
    }

    func testResetUserId() {
        let sut = Sut()
        sut.resetUserId()
        XCTAssertEqual(sut.trackEventEventEventVoidCallsCount, 1)
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.name, "Reset user")
    }

    func testSetProperty() {
        let sut = Sut()
        sut.setProperty("some property key", value: "some property values")
        XCTAssertEqual(sut.trackEventEventEventVoidCallsCount, 1)
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.name, "Set property")
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.parameters, ["some property key": "some property values"])
    }

    func testResetProperties() {
        let sut = Sut()
        sut.resetProperties()
        XCTAssertEqual(sut.trackEventEventEventVoidCallsCount, 1)
        XCTAssertEqual(sut.trackEventEventEventVoidReceivedEvent?.name, "Reset properties")
    }

    func testImplementContainsAny() {
        let sut = Sut()
        sut.supportedTags = [.debugging]
        XCTAssertTrue(sut.containsAny(from: [.crashReporting, .debugging]))
        XCTAssertFalse(sut.containsAny(from: [.crashReporting]))
    }

    func testImplementContainsNone() {
        let sut = Sut()
        sut.supportedTags = [.debugging]
        XCTAssertTrue(sut.containsNone(from: [.crashReporting, .analytics]))
        XCTAssertFalse(sut.containsNone(from: [.crashReporting, .debugging]))
    }
}
