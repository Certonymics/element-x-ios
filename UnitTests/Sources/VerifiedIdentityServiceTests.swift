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
        #expect(service.state(for: "@nobody:matrix.org") == .unverified)
    }
    
    @Test
    func recordWithoutRealNameIsKnown() {
        let service = VerifiedIdentityService(records: ["@marek:matrix.org": .identityOnly])
        #expect(service.state(for: "@marek:matrix.org") == .known)
    }
    
    @Test
    func recordWithRealNameIsVerified() {
        let service = VerifiedIdentityService(records: ["@ana:cemail.org": ana])
        #expect(service.state(for: "@ana:cemail.org") == .verified(realName: "Ana Kowalczyk", record: ana))
    }
    
    @Test
    func demoVerifiesTheSignedInUser() {
        let service = VerifiedIdentityService.demo(ownUserID: "@me:matrix.org")
        #expect(service.state(for: "@me:matrix.org").isVerified)
        #expect(VerifiedIdentityService.demo().state(for: "@me:matrix.org") == .unverified)
    }
}
