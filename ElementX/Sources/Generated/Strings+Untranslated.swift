// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal nonisolated enum UntranslatedL10n {
  /// Verify with ID
  internal static var actionVerifyWithId: String { return UntranslatedL10n.tr("Untranslated", "action_verify_with_id") }
  /// Country
  internal static var commonCountry: String { return UntranslatedL10n.tr("Untranslated", "common_country") }
  /// Government-issued ID
  internal static var commonGovernmentIssuedId: String { return UntranslatedL10n.tr("Untranslated", "common_government_issued_id") }
  /// Identity
  internal static var commonIdentity: String { return UntranslatedL10n.tr("Untranslated", "common_identity") }
  /// Linked email
  internal static var commonLinkedEmail: String { return UntranslatedL10n.tr("Untranslated", "common_linked_email") }
  /// Real name
  internal static var commonRealName: String { return UntranslatedL10n.tr("Untranslated", "common_real_name") }
  /// Real name unknown
  internal static var commonRealNameUnknown: String { return UntranslatedL10n.tr("Untranslated", "common_real_name_unknown") }
  /// Unverified
  internal static var commonUnverified: String { return UntranslatedL10n.tr("Untranslated", "common_unverified") }
  /// Verified identity
  internal static var commonVerifiedIdentity: String { return UntranslatedL10n.tr("Untranslated", "common_verified_identity") }
  /// Verified on
  internal static var commonVerifiedOn: String { return UntranslatedL10n.tr("Untranslated", "common_verified_on") }
  /// Verified with
  internal static var commonVerifiedWith: String { return UntranslatedL10n.tr("Untranslated", "common_verified_with") }
  /// Search
  internal static var screenHomeTabSearch: String { return UntranslatedL10n.tr("Untranslated", "screen_home_tab_search") }
  /// Link your legal name to %1$@ so people know it is really you.
  internal static func screenIdentitySettingsDescription(_ p1: Any) -> String {
    return UntranslatedL10n.tr("Untranslated", "screen_identity_settings_description", String(describing: p1))
  }
  /// Verify once with a government-issued ID. Your real name is shown next to your messages and in your profile. The document itself is never shared.
  internal static var screenIdentitySettingsNotVerifiedDescription: String { return UntranslatedL10n.tr("Untranslated", "screen_identity_settings_not_verified_description") }
  /// You verified your identity with a government-issued ID. Your legal name is linked to this account.
  internal static var screenIdentitySettingsVerifiedFooter: String { return UntranslatedL10n.tr("Untranslated", "screen_identity_settings_verified_footer") }
  /// %1$d of %2$d verified
  internal static func screenRoomMemberListVerifiedCount(_ p1: Int, _ p2: Int) -> String {
    return UntranslatedL10n.tr("Untranslated", "screen_room_member_list_verified_count", p1, p2)
  }
  /// Search for chats and messages
  internal static var screenSearchEmptyStateMessage: String { return UntranslatedL10n.tr("Untranslated", "screen_search_empty_state_message") }
  /// Start searching...
  internal static var screenSearchEmptyStateTitle: String { return UntranslatedL10n.tr("Untranslated", "screen_search_empty_state_title") }
  /// There are no results for “%1$@.” Try a new search term.
  internal static func screenSearchNoResultsMessage(_ p1: Any) -> String {
    return UntranslatedL10n.tr("Untranslated", "screen_search_no_results_message", String(describing: p1))
  }
  /// Chats
  internal static var screenSearchTabChats: String { return UntranslatedL10n.tr("Untranslated", "screen_search_tab_chats") }
  /// Messages
  internal static var screenSearchTabMessages: String { return UntranslatedL10n.tr("Untranslated", "screen_search_tab_messages") }
  /// This contact verified their identity with a government-issued ID, securely linking their legal name to this account.
  internal static var screenUserProfileVerifiedIdentityFooter: String { return UntranslatedL10n.tr("Untranslated", "screen_user_profile_verified_identity_footer") }
  /// Clear all data currently stored on this device?
  /// Sign in again to access your account data and messages.
  internal static var softLogoutClearDataDialogContent: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_clear_data_dialog_content") }
  /// Clear data
  internal static var softLogoutClearDataDialogTitle: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_clear_data_dialog_title") }
  /// Warning: Your personal data (including encryption keys) is still stored on this device.
  /// 
  /// Clear it if you’re finished using this device, or want to sign in to another account.
  internal static var softLogoutClearDataNotice: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_clear_data_notice") }
  /// Clear all data
  internal static var softLogoutClearDataSubmit: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_clear_data_submit") }
  /// Clear personal data
  internal static var softLogoutClearDataTitle: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_clear_data_title") }
  /// Sign in to recover encryption keys stored exclusively on this device. You need them to read all of your secure messages on any device.
  internal static var softLogoutSigninE2eWarningNotice: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_signin_e2e_warning_notice") }
  /// Your homeserver (%1$s) admin has signed you out of your account %2$s (%3$s).
  internal static func softLogoutSigninNotice(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>, _ p3: UnsafePointer<CChar>) -> String {
    return UntranslatedL10n.tr("Untranslated", "soft_logout_signin_notice", p1, p2, p3)
  }
  /// Sign in
  internal static var softLogoutSigninTitle: String { return UntranslatedL10n.tr("Untranslated", "soft_logout_signin_title") }
  /// Untranslated
  internal static var untranslated: String { return UntranslatedL10n.tr("Untranslated", "untranslated") }
  /// Plural format key: "%#@VARIABLE@"
  internal static func untranslatedPlural(_ p1: Int) -> String {
    return UntranslatedL10n.tr("Untranslated", "untranslated_plural", p1)
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

nonisolated extension UntranslatedL10n {
  static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // No need to check languages, we always default to en for untranslated strings
    guard let bundle = Bundle.lprojBundle(for: "en") else { return key }
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    return String(format: format, locale: Locale(identifier: "en"), arguments: args)
  }
}

// swiftlint:enable all
