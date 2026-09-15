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
        case .verified(let realName, _, matchesDisplayName: true):
            BadgeLabel(title: realName, icon: \.verified, style: .accent)
        case .verified(let realName, _, matchesDisplayName: false):
            BadgeLabel(title: UntranslatedL10n.commonVerifiedAs(realName), icon: \.warning, style: .critical)
        case .known:
            BadgeLabel(title: UntranslatedL10n.commonRealNameUnknown, icon: \.verified, style: .default)
        case .unverified:
            BadgeLabel(title: UntranslatedL10n.commonUnverified, icon: \.userProfile, style: .default)
        }
    }
}

struct VerifiedIdentityChip_Previews: PreviewProvider, TestablePreview {
    static let record = VerifiedIdentityRecord(realName: "Ana Kowalczyk", country: "Poland", verifiedOn: "12 Aug 2026", linkedEmail: "a.kowalczyk@cemail.org")
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            VerifiedIdentityChip(state: .verified(realName: "Ana Kowalczyk", record: record, matchesDisplayName: true))
            VerifiedIdentityChip(state: .verified(realName: "Ana Kowalczyk", record: record, matchesDisplayName: false))
            VerifiedIdentityChip(state: .known)
            VerifiedIdentityChip(state: .unverified)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
