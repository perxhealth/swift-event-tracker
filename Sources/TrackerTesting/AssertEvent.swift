import Foundation
import Tracker
import XCTest

public func AsserttrackEventEventEventVoidCalled(_ provider: ServiceMock,
                                 message: @autoclosure () -> String = "",
                                 file: StaticString = #file,
                                 line: UInt = #line) {
    XCTAssertTrue(provider.trackEventEventEventVoidCalled,
                  message(),
                  file: file,
                  line: line)
}

public func AssertTrackEventNotCalled(_ provider: ServiceMock,
                                    message: @autoclosure () -> String = "",
                                    file: StaticString = #file,
                                    line: UInt = #line) {
    XCTAssertFalse(provider.trackEventEventEventVoidCalled,
                   message(),
                   file: file,
                   line: line)
}

public func AssertEventTracked(_ event: NamedEvent,
                               params: [String: String] = [:],
                               to provider: ServiceMock,
                               message: @autoclosure () -> String = "",
                               file: StaticString = #file,
                               line: UInt = #line) {
    let lastEvent = provider.trackEventEventEventVoidReceivedEvent
    XCTAssertEqual(lastEvent?.name,
                   event.name,
                   message(),
                   file: file,
                   line: line)
    XCTAssertEqual(lastEvent?.resolvedParameters,
                   params,
                   message(),
                   file: file,
                   line: line)
}

public func AssertEventNotTracked(_ event: NamedEvent,
                                  to provider: ServiceMock,
                                  message: @autoclosure () -> String = "",
                                  file: StaticString = #file,
                                  line: UInt = #line) {
    XCTAssertNotEqual(provider.trackEventEventEventVoidReceivedEvent?.name,
                      event.name,
                      message(),
                      file: file,
                      line: line)
}

public func AssertEventsTracked(_ events: NamedEvent...,
                                to provider: ServiceMock,
                                ignoreAdditionalEvents: Bool = false,
                                message: @autoclosure () -> String = "",
                                file: StaticString = #file,
                                line: UInt = #line) {
    XCTAssertGreaterThan(events.count,
                         1,
                         "Use AssertEventTracked() instead",
                         file: file,
                         line: line)
    let selected = provider
        .trackEventEventEventVoidReceivedInvocations
        .filter { event in !ignoreAdditionalEvents || events.map { $0.name }.contains(event.name) }
    XCTAssertEqual(selected.map { $0.name },
                   events.map { $0.name },
                   message(),
                   file: file,
                   line: line)
}
