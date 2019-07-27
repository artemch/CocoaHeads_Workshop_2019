// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum L10n {
  public enum Errors {
    /// Access Token missing
    public static let accessTokenMissing = L10n.tr("Errors", "access_token_missing")
    /// You must agree with terms and conditions
    public static let agreeWithTermsAndConditions = L10n.tr("Errors", "agree_with_terms_and_conditions")
    /// Display Name should be minimum %d characters
    public static func displayNameMinLength(_ p1: Int) -> String {
      return L10n.tr("Errors", "display_name_min_length", p1)
    }
    /// Couldn’t connect to the server
    public static let errorConnectToTheServer = L10n.tr("Errors", "error_connect_to_the_server")
    /// Failed transform image to data
    public static let failedTransformImageToData = L10n.tr("Errors", "failed_transform_image_to_data")
    /// Failed to load goal
    public static let feiledToLoadGoal = L10n.tr("Errors", "feiled_to_load_goal")
    /// Food should be choosen
    public static let foodShouldBeChoosen = L10n.tr("Errors", "food_should_be_choosen")
    /// inputFailed
    public static let inputFailed = L10n.tr("Errors", "input_failed")
    /// Invalid email
    public static let invalidEmail = L10n.tr("Errors", "invalid_email")
    /// Invalid password
    public static let invalidPassword = L10n.tr("Errors", "invalid_password")
    /// No Token
    public static let noToken = L10n.tr("Errors", "no_token")
    /// New password should not match old
    public static let passwordsMustNotMatch = L10n.tr("Errors", "passwords_must_not_match")
    /// responseFailed
    public static let responseFailed = L10n.tr("Errors", "response_failed")
    /// Server should return meal type
    public static let shouldBeMealType = L10n.tr("Errors", "should_be_meal_type")
    /// undefined
    public static let undefined = L10n.tr("Errors", "undefined")
    /// Undefined email error!
    public static let undefinedEmailError = L10n.tr("Errors", "undefined_email_error")
  }
  public enum Localization {
    /// Back
    public static let back = L10n.tr("Localization", "back")
    /// OK
    public static let ok = L10n.tr("Localization", "ok")
    /// Retry
    public static let retry = L10n.tr("Localization", "retry")
  }
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
