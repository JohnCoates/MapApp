//
//  Forward.swift
//

import Foundation

/// Forwards a property to an internal object
@propertyWrapper
struct Forward<Value, EnclosingSelf> {
    private let keyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>

    init(_ keyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>) {
        self.keyPath = keyPath
    }

    var wrappedValue: Value {
        get { fatalError("Incorrect usage") }
        set { fatalError("Incorrect usage") }
    }

    public static subscript(_enclosingInstance observed: EnclosingSelf,
                            wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
                            storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>) -> Value {
        get {
            let stored = observed[keyPath: storageKeyPath]
            let value = observed[keyPath: stored.keyPath]
            return value
        }
        set {
            let stored = observed[keyPath: storageKeyPath]
            observed[keyPath: stored.keyPath] = newValue
        }
    }
}
