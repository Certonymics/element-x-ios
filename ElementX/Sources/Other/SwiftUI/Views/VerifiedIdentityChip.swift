//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Compound
import SwiftUI

/// The c.email identity state shown next to a user's name.
struct VerifiedIdentityChip: View {
    let state: VerifiedIdentityState
    
    var body: some View {
        switch state {
        case .verified:
            BadgeLabel(title: state.title, icon: \.verified, style: .accent)
        case .known:
            BadgeLabel(title: state.title, icon: \.verified, style: .default)
        case .unverified:
            BadgeLabel(title: state.title, icon: \.userProfile, style: .default)
        }
    }
}

nonisolated extension VerifiedIdentityState {
    /// The chip's text, also read to VoiceOver where the chip itself is hidden.
    var title: String {
        switch self {
        case .verified(let realName, _):
            realName
        case .known:
            UntranslatedL10n.commonRealNameUnknown
        case .unverified:
            UntranslatedL10n.commonUnverified
        }
    }
}

struct VerifiedIdentityChip_Previews: PreviewProvider, TestablePreview {
    static let record = VerifiedIdentityRecord(realName: "Ana Kowalczyk", country: "Poland", verifiedOn: "12 Aug 2026", linkedEmail: "a.kowalczyk@cemail.org")
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            VerifiedIdentityChip(state: .verified(realName: "Ana Kowalczyk", record: record))
            VerifiedIdentityChip(state: .known)
            VerifiedIdentityChip(state: .unverified)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
