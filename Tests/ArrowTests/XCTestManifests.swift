import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ArrayTests.allTests),
        testCase(CustomModelTests.allTests),
        testCase(CustomRawRepresentableTests.allTests),
        testCase(DateTests.allTests),
        testCase(EnumTests.allTests),
        testCase(NativeTypesTests.allTests),
        testCase(StringCoercionTests.allTests),
        testCase(StringTests.allTests),
        testCase(TypeConversionTests.allTests),
        testCase(URLTests.allTests),
    ]
}
#endif
