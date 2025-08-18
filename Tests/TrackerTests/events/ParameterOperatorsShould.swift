import XCTest
@testable import Tracker

final class ParameterOperatorsShould: XCTestCase {
    func testAddRequiredTagsToParameter() {
        let parameter = NamedParameter(key: "test", value: "value")
        let requiredTags: [Tag] = [.analytics, .crashReporting]
        
        let taggedParameter = parameter + requiredTags
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.requiredTags, requiredTags)
        XCTAssertTrue(taggedParameter.excludedTags.isEmpty)
    }
    
    func testAddRequiredTagsToParameterReversed() {
        let parameter = NamedParameter(key: "test", value: "value")
        let requiredTags: [Tag] = [.analytics, .crashReporting]
        
        let taggedParameter = requiredTags + parameter
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.requiredTags, requiredTags)
        XCTAssertTrue(taggedParameter.excludedTags.isEmpty)
    }
    
    func testAddSingleRequiredTagToParameter() {
        let parameter = NamedParameter(key: "test", value: "value")
        let requiredTag = Tag.analytics
        
        let taggedParameter = parameter + requiredTag
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.requiredTags, [requiredTag])
        XCTAssertTrue(taggedParameter.excludedTags.isEmpty)
    }
    
    func testAddSingleRequiredTagToParameterReversed() {
        let parameter = NamedParameter(key: "test", value: "value")
        let requiredTag = Tag.analytics
        
        let taggedParameter = requiredTag + parameter
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.requiredTags, [requiredTag])
        XCTAssertTrue(taggedParameter.excludedTags.isEmpty)
    }
    
    func testSubtractExcludedTagsFromParameter() {
        let parameter = NamedParameter(key: "test", value: "value")
        let excludedTags: [Tag] = [.debugging, .logging]
        
        let taggedParameter = parameter - excludedTags
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.excludedTags, excludedTags)
        XCTAssertTrue(taggedParameter.requiredTags.isEmpty)
    }
    
    func testSubtractExcludedTagsFromParameterReversed() {
        let parameter = NamedParameter(key: "test", value: "value")
        let excludedTags: [Tag] = [.debugging, .logging]
        
        let taggedParameter = excludedTags - parameter
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.excludedTags, excludedTags)
        XCTAssertTrue(taggedParameter.requiredTags.isEmpty)
    }
    
    func testSubtractSingleExcludedTagFromParameter() {
        let parameter = NamedParameter(key: "test", value: "value")
        let excludedTag = Tag.debugging
        
        let taggedParameter = parameter - excludedTag
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.excludedTags, [excludedTag])
        XCTAssertTrue(taggedParameter.requiredTags.isEmpty)
    }
    
    func testSubtractSingleExcludedTagFromParameterReversed() {
        let parameter = NamedParameter(key: "test", value: "value")
        let excludedTag = Tag.debugging
        
        let taggedParameter = excludedTag - parameter
        
        XCTAssertEqual(taggedParameter.key, parameter.key)
        XCTAssertEqual(taggedParameter.value, parameter.value)
        XCTAssertEqual(taggedParameter.excludedTags, [excludedTag])
        XCTAssertTrue(taggedParameter.requiredTags.isEmpty)
    }
    
    func testChainOperators() {
        let parameter = NamedParameter(key: "user_type", value: "premium")
        let taggedParameter = parameter + Tag.analytics - Tag.debugging
        
        XCTAssertEqual(taggedParameter.key, "user_type")
        XCTAssertEqual(taggedParameter.value, "premium")
        XCTAssertEqual(taggedParameter.requiredTags, [Tag.analytics])
        XCTAssertEqual(taggedParameter.excludedTags, [Tag.debugging])
    }
}
