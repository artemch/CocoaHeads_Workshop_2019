// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Agree and continue
  internal static let agreeAndContinue = L10n.tr("Localizable", "agree_and_continue")
  /// I agree to all the %@
  internal static func agreeToAll(_ p1: String) -> String {
    return L10n.tr("Localizable", "agree_to_all", p1)
  }
  /// Back
  internal static let back = L10n.tr("Localizable", "back")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Current password
  internal static let currentPasswordPlaceholder = L10n.tr("Localizable", "current_password_placeholder")
  /// I don't have an account
  internal static let doNotHaveAnAccount = L10n.tr("Localizable", "do_not_have_an_account")
  /// Done
  internal static let done = L10n.tr("Localizable", "done")
  /// Email
  internal static let emailPlaceholder = L10n.tr("Localizable", "email_placeholder")
  /// Forgot password?
  internal static let forgotPassword = L10n.tr("Localizable", "forgot_password")
  /// Full Name
  internal static let fullNamePlaceholder = L10n.tr("Localizable", "full_name_placeholder")
  /// I already have an account
  internal static let haveAnAccount = L10n.tr("Localizable", "have_an_account")
  /// Sign In
  internal static let login = L10n.tr("Localizable", "login")
  /// New password
  internal static let newPasswordPlaceholder = L10n.tr("Localizable", "new_password_placeholder")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Password
  internal static let passwordPlaceholder = L10n.tr("Localizable", "password_placeholder")
  /// Send reset link
  internal static let resetPassword = L10n.tr("Localizable", "reset_password")
  /// We’ve sent you an email
  internal static let resetPasswordResultTitle = L10n.tr("Localizable", "reset_password_result_title")
  /// Password reset
  internal static let resetPasswordTitle = L10n.tr("Localizable", "reset_password_title")
  /// Sign Out
  internal static let signOut = L10n.tr("Localizable", "sign_out")
  /// Sign In with Google
  internal static let signinGoogle = L10n.tr("Localizable", "signin_google")
  /// Sign in
  internal static let signinTitle = L10n.tr("Localizable", "signin_title")
  /// Register
  internal static let signup = L10n.tr("Localizable", "signup")
  /// CocoaHeads Kyiv 2019
  internal static let signupSigninTitleMessage = L10n.tr("Localizable", "signup_signin_title_message")
  /// Welcome to CocoaHeads workshop!
  internal static let signupSigninWelcomeMessage = L10n.tr("Localizable", "signup_signin_welcome_message")
  /// Register
  internal static let signupTitle = L10n.tr("Localizable", "signup_title")
  /// Profile
  internal static let tabBarProfile = L10n.tr("Localizable", "tab_bar_profile")
  /// terms and conditions
  internal static let termsAndConditions = L10n.tr("Localizable", "terms_and_conditions")
  /// Terms and Conditions
  internal static let termsAndConditionsTitle = L10n.tr("Localizable", "terms_and_conditions_title")
  /// We’ll send you a reset link
  internal static let weWillSendYouAResetLink = L10n.tr("Localizable", "we_will_send_you_a_reset_link")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
