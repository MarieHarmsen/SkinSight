import Foundation

internal enum GeneralStrings {
    /// Skin Sight
    internal static let appTitle = GeneralStrings.tr("General", "Title.AppName")
    /// Log In
    internal static let loginTitle = GeneralStrings.tr("General", "Authentication.login")
    /// Create New Account
    internal static let forgotPasswordTitle = GeneralStrings.tr("General", "Authentication.forgotPassword")
    /// Sign Up
    internal static let SignUpTitle = GeneralStrings.tr("General", "Authentication.signUp")
    /// Email address
    internal static let email = GeneralStrings.tr("General", "Authentication.email")
    /// Password
    internal static let password = GeneralStrings.tr("General", "Authentication.password")
    /// OR
    internal static let or = GeneralStrings.tr("General", "Authentication.or")
    /// Create New Account
    internal static let account = GeneralStrings.tr("General", "Authentication.account")
    /// Continue with Apple
    internal static let apple = GeneralStrings.tr("General", "Authentication.apple")
    /// Continue with Google
    internal static let google = GeneralStrings.tr("General", "Authentication.google")
    /// Continue with Facebook
    internal static let facebook = GeneralStrings.tr("General", "Authentication.facebook")
}

extension GeneralStrings {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
