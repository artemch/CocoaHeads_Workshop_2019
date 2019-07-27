import Foundation

extension F {
    static func formattedFormField<Value>(value: Value?, values: String...) -> String? {
        return value.map { "\($0)" + values.joined() }
    }
}

extension F {
    static func formattedFormField<Value>(value: Value?, placeholder: Value) -> String {
        return value.map { "\($0)" } ?? "\(placeholder)"
    }
}
