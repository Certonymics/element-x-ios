//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Combine
import SwiftUI

struct IdentitySettingsScreenCoordinatorParameters {
    let userID: String
    let verifiedIdentityService: VerifiedIdentityService
}

final class IdentitySettingsScreenCoordinator: CoordinatorProtocol {
    private let viewModel: IdentitySettingsScreenViewModelProtocol
    
    init(parameters: IdentitySettingsScreenCoordinatorParameters) {
        viewModel = IdentitySettingsScreenViewModel(userID: parameters.userID,
                                                    verifiedIdentityService: parameters.verifiedIdentityService)
    }
    
    func toPresentable() -> AnyView {
        AnyView(IdentitySettingsScreen(context: viewModel.context))
    }
}
