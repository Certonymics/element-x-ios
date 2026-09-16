//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import SwiftUI

/// A c.email identity record for a Matrix user: a legal name bound to the account by a government-issued ID.
nonisolated struct VerifiedIdentityRecord: Hashable, Sendable {
    /// The legal name from the ID document. `nil` when the user has a c.email identity but no ID check yet.
    let realName: String?
    let country: String?
    let verifiedOn: String?
    let linkedEmail: String?
    
    /// A user who is on c.email but hasn't verified their name with a document yet.
    static let identityOnly = VerifiedIdentityRecord(realName: nil, country: nil, verifiedOn: nil, linkedEmail: nil)
}

nonisolated enum VerifiedIdentityState: Hashable, Sendable {
    /// `shownAs` is the display name when it claims to be a different person than `realName`, otherwise `nil`.
    case verified(realName: String, record: VerifiedIdentityRecord, shownAs: String?)
    /// On c.email, but the real name isn't known yet.
    case known
    case unverified
    
    var isVerified: Bool {
        if case .verified = self {
            true
        } else {
            false
        }
    }
}

/// Resolves c.email identity records for Matrix users.
///
/// Demo build: the records are hardcoded below. The real implementation resolves the
/// account's email through the identity server, then the c.email DID and its KYC proof.
nonisolated struct VerifiedIdentityService: Sendable {
    private let records: [String: VerifiedIdentityRecord]
    private let ownUserID: String?
    
    /// Edit this map to add the accounts used in a demo.
    static let demoRecords: [String: VerifiedIdentityRecord] = [
        "@alice:matrix.org": .init(realName: "Alice", country: "Poland", verifiedOn: "12 Aug 2026", linkedEmail: "alice@cemail.org"),
        "@bob:matrix.org": .init(realName: "Bartek Nowak", country: "Poland", verifiedOn: "3 Sep 2026", linkedEmail: "b.nowak@cemail.org"),
        "@charlie:matrix.org": .identityOnly,
        "@dan:matrix.org": .init(realName: "Dan", country: "Ireland", verifiedOn: "28 Jul 2026", linkedEmail: "dan@cemail.org"),
        "@chatxsanmcc:matrix.org": .init(realName: "Jan Kowalski", country: "Poland", verifiedOn: "9 Sep 2026", linkedEmail: "jan.kowalski@cemail.org"),
        "@kk-test1:matrix.org": .init(realName: "Kamil Test", country: "Poland", verifiedOn: "3 Sep 2026", linkedEmail: "kamil.test@cemail.org"),
        // On c.email, no ID check yet.
        "@kamilcertonymity:matrix.org": .identityOnly,
        "@helena:matrix.org": .init(realName: "Helena", country: "Poland", verifiedOn: "12 Aug 2026", linkedEmail: "helena@cemail.org"),
        "@marek:matrix.org": .identityOnly
    ]
    
    static let demoOwnRecord = VerifiedIdentityRecord(realName: "Kamil Kurowski", country: "Poland", verifiedOn: "15 Sep 2026", linkedEmail: "kamil@cemail.org")
    
    init(records: [String: VerifiedIdentityRecord], ownUserID: String? = nil) {
        self.records = records
        self.ownUserID = ownUserID
    }
    
    /// The demo records, plus the signed-in user verified under `demoOwnRecord`.
    static func demo(ownUserID: String? = nil) -> VerifiedIdentityService {
        var records = demoRecords
        if let ownUserID {
            records[ownUserID] = demoOwnRecord
        }
        return VerifiedIdentityService(records: records, ownUserID: ownUserID)
    }
    
    /// The identity state for a user, flagging a display name that claims to be someone other than the verified person.
    func state(for userID: String, displayName: String?) -> VerifiedIdentityState {
        guard let record = records[userID] else { return .unverified }
        guard let realName = record.realName else { return .known }
        let shownAs = userID == ownUserID ? nil : Self.nameClaim(in: displayName, differingFrom: realName)
        return .verified(realName: realName, record: record, shownAs: shownAs)
    }
    
    /// The display name when it doesn't match `realName` after trimming and case/diacritic folding. A handle such as
    /// `chatxsanmcc` counts too: anything other than the verified name hides who the person really is.
    private static func nameClaim(in displayName: String?, differingFrom realName: String) -> String? {
        guard let displayName, fold(displayName) != fold(realName) else { return nil }
        return displayName
    }
    
    private static func fold(_ name: String) -> String {
        name.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
    }
}

extension EnvironmentValues {
    @Entry var verifiedIdentityService = VerifiedIdentityService.demo()
}
