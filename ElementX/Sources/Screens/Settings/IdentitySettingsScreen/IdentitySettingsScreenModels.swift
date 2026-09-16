//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Foundation

// periphery:ignore - required for the architecture
enum IdentitySettingsScreenViewModelAction { }

struct IdentitySettingsScreenViewState: BindableState {
    let userID: String
    var verifiedIdentity: VerifiedIdentityState
}

enum IdentitySettingsScreenViewAction {
    case verify
}
