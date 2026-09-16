//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Combine
import SwiftUI

typealias IdentitySettingsScreenViewModelType = StateStoreViewModelV2<IdentitySettingsScreenViewState, IdentitySettingsScreenViewAction>

class IdentitySettingsScreenViewModel: IdentitySettingsScreenViewModelType, IdentitySettingsScreenViewModelProtocol {
    init(userID: String, verifiedIdentityService: VerifiedIdentityService) {
        super.init(initialViewState: IdentitySettingsScreenViewState(userID: userID,
                                                                     verifiedIdentity: verifiedIdentityService.state(for: userID)))
    }
    
    override func process(viewAction: IdentitySettingsScreenViewAction) {
        switch viewAction {
        case .verify:
            // Demo: there is no ID check flow yet, verifying flips straight to the verified state.
            let record = VerifiedIdentityService.demoOwnRecord
            state.verifiedIdentity = .verified(realName: record.realName ?? state.userID, record: record)
        }
    }
}
