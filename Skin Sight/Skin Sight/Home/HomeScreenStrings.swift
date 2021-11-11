import Foundation

internal enum HomeScreenStrings {
    /// Take Photo
    internal static let photo = HomeScreenStrings.tr("HomeScreen", "Homescreen.photo")
    /// Open Gallery
    internal static let gallery = HomeScreenStrings.tr("HomeScreen", "Homescreen.gallery")
}

extension HomeScreenStrings {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
