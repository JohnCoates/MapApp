//
//  DebugPrint.swift
//

import Foundation
import os.log

private let log = OSLog(subsystem: "com.johncoates", category: "debug.print")

@available(*, deprecated, message: "Remove when done debugging.")
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    _print(items: items, separator: separator, terminator: terminator)
}

@available(*, deprecated, message: "Remove when done debugging.")
func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    _print(items: items, separator: separator, terminator: terminator)
}

/// Print statement that should be kept in the application.
func productionPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    _print(items: items, separator: separator, terminator: terminator)
}

private func _print(items: [Any], separator: String, terminator: String) {
    logPrint(items: items, separator: separator)
}

private func logPrint(items: [Any], separator: String = " ") {
    let message = items.map({ internalDescribe($0) }).joined(separator: separator)
    os_log("%{public}@", log: log, message)
}

private func internalDescribe(_ value: Any) -> String {
    if let internalDescription = value as? InternalDescription {
        return internalDescription.internalDescription
    }

    return String(describing: value)
}
