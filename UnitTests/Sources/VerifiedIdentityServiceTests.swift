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
    let bartek = VerifiedIdentityRecord(realName: "Bartek Nowak", country: "Poland", verifiedOn: "3 Sep 2026", linkedEmail: "b.nowak@cemail.org")
    
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
    func recordWithRealNameIsVerified() {
        let service = VerifiedIdentityService(records: ["@ana:cemail.org": ana])
        #expect(service.state(for: "@ana:cemail.org", displayName: "Ana Kowalczyk") == .verified(realName: "Ana Kowalczyk", record: ana, shownAs: nil))
    }
    
    @Test
    func handleDisplayNameIsNotAClaim() {
        let jan = VerifiedIdentityRecord(realName: "Jan Kowalski", country: "Poland", verifiedOn: "9 Sep 2026", linkedEmail: "jan.kowalski@cemail.org")
        let service = VerifiedIdentityService(records: ["@chatxsanmcc:matrix.org": jan])
        #expect(service.state(for: "@chatxsanmcc:matrix.org", displayName: "chatxsanmcc") == .verified(realName: "Jan Kowalski", record: jan, shownAs: nil))
    }
    
    @Test
    func differentRealLookingNameIsFlagged() {
        let service = VerifiedIdentityService(records: ["@bob:matrix.org": bartek])
        #expect(service.state(for: "@bob:matrix.org", displayName: "Alice Chen · CEO") == .verified(realName: "Bartek Nowak", record: bartek, shownAs: "Alice Chen · CEO"))
    }
    
    @Test
    func matchingNameIsNotFlagged() {
        let service = VerifiedIdentityService(records: ["@bob:matrix.org": bartek])
        #expect(service.state(for: "@bob:matrix.org", displayName: "  bartek NOWAK ") == .verified(realName: "Bartek Nowak", record: bartek, shownAs: nil))
    }
    
    @Test
    func ownUserIsNeverFlagged() {
        let service = VerifiedIdentityService.demo(ownUserID: "@me:matrix.org")
        #expect(service.state(for: "@me:matrix.org", displayName: "Anything Else") == .verified(realName: "Kamil Kurowski", record: VerifiedIdentityService.demoOwnRecord, shownAs: nil))
    }
    
    @Test
    func demoVerifiesTheSignedInUser() {
        let service = VerifiedIdentityService.demo(ownUserID: "@me:matrix.org")
        #expect(service.state(for: "@me:matrix.org", displayName: nil).isVerified)
        #expect(VerifiedIdentityService.demo().state(for: "@me:matrix.org", displayName: nil) == .unverified)
    }
}
