import XCTest

import MyPackageTests

var tests = [XCTestCaseEntry]()
tests += ArrayTests.allTests()
tests += CustomModelTests.allTests()
tests += CustomRawRepresentableTests.allTests()
tests += DateTests.allTests()
tests += EnumTests.allTests()
tests += NativeTypesTests.allTests()
tests += StringCoercionTests.allTests()
tests += StringTests.allTests()
tests += TypeConversionTests.allTests()
tests += URLTests.allTests()
XCTMain(tests)
