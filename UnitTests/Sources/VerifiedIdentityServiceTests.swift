//
// Copyright 2025 Element Creations Ltd.
// Copyright 2022-2025 New Vector Ltd.
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
    func demoVerifiesTheSignedInUser() {
        let service = VerifiedIdentityService.demo(ownUserID: "@me:matrix.org")
        #expect(service.state(for: "@me:matrix.org", displayName: nil).isVerified)
        #expect(VerifiedIdentityService.demo().state(for: "@me:matrix.org", displayName: nil) == .unverified)
    }
}
