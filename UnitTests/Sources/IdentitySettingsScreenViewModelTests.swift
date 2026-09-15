//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

@testable import ElementX
import Testing

@MainActor
struct IdentitySettingsScreenViewModelTests {
    @Test
    func unknownUserStartsUnverified() {
        let viewModel = IdentitySettingsScreenViewModel(userID: "@me:matrix.org", verifiedIdentityService: VerifiedIdentityService(records: [:]))
        #expect(viewModel.context.viewState.verifiedIdentity == .unverified)
    }
    
    @Test
    func verifyingMarksTheUserVerified() {
        let viewModel = IdentitySettingsScreenViewModel(userID: "@me:matrix.org", verifiedIdentityService: VerifiedIdentityService(records: [:]))
        viewModel.context.send(viewAction: .verify)
        #expect(viewModel.context.viewState.verifiedIdentity.isVerified)
    }
    
    @Test
    func verifiedUserStartsVerified() {
        let viewModel = IdentitySettingsScreenViewModel(userID: "@me:matrix.org", verifiedIdentityService: .demo(ownUserID: "@me:matrix.org"))
        #expect(viewModel.context.viewState.verifiedIdentity.isVerified)
    }
}
