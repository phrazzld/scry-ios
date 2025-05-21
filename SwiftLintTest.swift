// Test file for SwiftLint pre-commit hook

import Foundation

func testFunction() {
    // SwiftLint violation: print statement
    print("This is a test")
    
    // SwiftLint violation: trailing whitespace
    let test = "test"    
    
    // SwiftLint violation: line length
    let reallyLongString = "This is a really long string that should trigger the line length warning in SwiftLint because it exceeds the 140 character limit that we have configured"
    
    // Use the variables to avoid unused variable warnings
    _ = test
    _ = reallyLongString
}