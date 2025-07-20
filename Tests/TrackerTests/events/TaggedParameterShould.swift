import XCTest
@testable import Tracker

final class TaggedParameterShould: XCTestCase {
    private let baseParameter = NamedParameter(key: "test_key", value: "test_value")
    
    func testInitializeWithParameter() {
        let taggedParameter = TaggedParameter(parameter: baseParameter)
        
        XCTAssertEqual(taggedParameter.key, baseParameter.key)
        XCTAssertEqual(taggedParameter.value, baseParameter.value)
        XCTAssertTrue(taggedParameter.excludedTags.isEmpty)
        XCTAssertTrue(taggedParameter.requiredTags.isEmpty)
    }
    
    func testAddExcludedTags() {
        let excludedTags: [Tag] = [.debugging, .logging]
        let taggedParameter = TaggedParameter(parameter: baseParameter, excludedTags: excludedTags)
        
        XCTAssertEqual(taggedParameter.key, baseParameter.key)
        XCTAssertEqual(taggedParameter.value, baseParameter.value)
        XCTAssertEqual(taggedParameter.excludedTags, excludedTags)
        XCTAssertTrue(taggedParameter.requiredTags.isEmpty)
    }
    
    func testAddRequiredTags() {
        let requiredTags: [Tag] = [.analytics, .crashReporting]
        let taggedParameter = TaggedParameter(parameter: baseParameter, requiredTags: requiredTags)
        
        XCTAssertEqual(taggedParameter.key, baseParameter.key)
        XCTAssertEqual(taggedParameter.value, baseParameter.value)
        XCTAssertTrue(taggedParameter.excludedTags.isEmpty)
        XCTAssertEqual(taggedParameter.requiredTags, requiredTags)
    }
    
    func testAddBothExcludedAndRequiredTags() {
        let excludedTags: [Tag] = [.debugging]
        let requiredTags: [Tag] = [.analytics]
        let taggedParameter = TaggedParameter(
            parameter: baseParameter,
            excludedTags: excludedTags,
            requiredTags: requiredTags
        )
        
        XCTAssertEqual(taggedParameter.key, baseParameter.key)
        XCTAssertEqual(taggedParameter.value, baseParameter.value)
        XCTAssertEqual(taggedParameter.excludedTags, excludedTags)
        XCTAssertEqual(taggedParameter.requiredTags, requiredTags)
    }
    
    func testMergeTagsWithBaseParameter() {
        let parameter = NamedParameter(
            key: "test_key",
            value: "test_value",
        )
        
        let additionalExcludedTags: [Tag] = [.logging, .debugging]
        let additionalRequiredTags: [Tag] = [.crashReporting, .analytics]
        let taggedParameter = TaggedParameter(
            parameter: parameter,
            excludedTags: additionalExcludedTags,
            requiredTags: additionalRequiredTags
        )
        
        XCTAssertEqual(taggedParameter.excludedTags.count, 2)
        XCTAssertTrue(taggedParameter.excludedTags.contains(.debugging))
        XCTAssertTrue(taggedParameter.excludedTags.contains(.logging))
        
        XCTAssertEqual(taggedParameter.requiredTags.count, 2)
        XCTAssertTrue(taggedParameter.requiredTags.contains(.analytics))
        XCTAssertTrue(taggedParameter.requiredTags.contains(.crashReporting))
    }
}
