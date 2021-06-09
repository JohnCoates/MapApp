//
//  Optional+InternalDescription.swift
//

import Foundation

extension Optional: InternalDescription {
    var internalDescription: String {
        switch self {
        case .none:
            return "nil"
        case .some(let value):
            if let value = value as? InternalDescription {
                return value.internalDescription
            } else {
                return String(describing: value)
            }
        }
    }
}
