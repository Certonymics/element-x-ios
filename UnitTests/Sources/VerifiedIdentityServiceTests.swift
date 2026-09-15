//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

@testable import ElementX
import Testing

struct VerifiedIdentityServiceTests {
    let ana = VerifiedIdentityRecord(realName: "Ana Kowalczyk", country: "Poland", verifiedOn: "12 Aug 2026", linkedEmail: "a.kowalczyk@cemail.org")
    
    @Test
    func unknownUserIsUnverified() {
        let service = VerifiedIdentityService(records: [:])
        #expect(service.state(for: "@nobody:matrix.org", displayName: "Nobody") == .unverified)
    }
    
    @Test
    func recordWithoutRealNameIsKnown() {
        let service = VerifiedIdentityService(records: ["@marek:matrix.org": .identityOnly])
        #expect(service.state(for: "@marek:matrix.org", displayName: "marek") == .known)
    }
    
    @Test
    func matchingDisplayNameIsVerified() {
        let service = VerifiedIdentityService(records: ["@ana:cemail.org": ana])
        #expect(service.state(for: "@ana:cemail.org", displayName: "  ana KOWALCZYK ") == .verified(realName: "Ana Kowalczyk", record: ana, matchesDisplayName: true))
    }
    
    @Test
    func differentDisplayNameIsMismatch() {
        let service = VerifiedIdentityService(records: ["@ana:cemail.org": ana])
        #expect(service.state(for: "@ana:cemail.org", displayName: "Alice Chen · CEO") == .verified(realName: "Ana Kowalczyk", record: ana, matchesDisplayName: false))
    }
    
    @Test
    func missingDisplayNameCountsAsMatch() {
        let service = VerifiedIdentityService(records: ["@ana:cemail.org": ana])
        #expect(service.state(for: "@ana:cemail.org", displayName: nil) == .verified(realName: "Ana Kowalczyk", record: ana, matchesDisplayName: true))
    }
    
    @Test
    func ownDisplayNameNeverMismatches() {
        let service = VerifiedIdentityService.demo(ownUserID: "@me:matrix.org")
        guard case .verified(_, _, let matchesDisplayName) = service.state(for: "@me:matrix.org", displayName: "kamil (work)") else {
            Issue.record("Expected the signed-in user to be verified")
            return
        }
        #expect(matchesDisplayName)
    }
    
    @Test
    func demoVerifiesTheSignedInUser() {
        let service = VerifiedIdentityService.demo(ownUserID: "@me:matrix.org")
        #expect(service.state(for: "@me:matrix.org", displayName: nil).isVerified)
        #expect(VerifiedIdentityService.demo().state(for: "@me:matrix.org", displayName: nil) == .unverified)
    }
    
    @Test
    func diacriticsDoNotBreakTheMatch() {
        let record = VerifiedIdentityRecord(realName: "Zofia Wiśniewska", country: "Poland", verifiedOn: "1 Sep 2026", linkedEmail: "zofia@cemail.org")
        let service = VerifiedIdentityService(records: ["@zofia:cemail.org": record])
        #expect(service.state(for: "@zofia:cemail.org", displayName: "Zofia Wisniewska") == .verified(realName: "Zofia Wiśniewska", record: record, matchesDisplayName: true))
    }
}
