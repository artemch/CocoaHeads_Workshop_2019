import Foundation

extension L10n {
    static func tr(_ key: String) -> String {
        let format = NSLocalizedString(key, tableName: "Localizable", bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current)
    }
}

private final class BundleToken {}
