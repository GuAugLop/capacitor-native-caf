import Foundation

@objc public class Caf: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
