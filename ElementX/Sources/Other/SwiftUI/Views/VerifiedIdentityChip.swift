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
        case .verified(_, _, shownAs: nil):
            BadgeLabel(title: state.title, icon: \.verified, style: .tinted(text: .cemailVerified, background: .cemailVerifiedTint))
        case .verified(_, _, shownAs: .some):
            BadgeLabel(title: state.title, icon: \.warning, style: .tinted(text: .cemailWarning, background: .cemailWarningTint))
        case .known:
            BadgeLabel(title: state.title, icon: \.verified, style: .default)
        case .unverified:
            BadgeLabel(title: state.title, icon: \.userProfile, style: .critical)
        }
    }
}

/// c.email's verified-identity blue, matching the c.email apps rather than Element's accent.
extension Color {
    static let cemailVerified = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 0xEB / 255, green: 0xF5 / 255, blue: 0xFF / 255, alpha: 1) : UIColor(red: 0x56 / 255, green: 0x6A / 255, blue: 0xFD / 255, alpha: 1)
    })
    
    static let cemailVerifiedTint = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 0x1F / 255, green: 0x23 / 255, blue: 0x39 / 255, alpha: 1) : UIColor(red: 0xEB / 255, green: 0xF5 / 255, blue: 0xFF / 255, alpha: 1)
    })
    
    static let cemailWarning = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 0xFF / 255, green: 0xE9 / 255, blue: 0xD6 / 255, alpha: 1) : UIColor(red: 0xFF / 255, green: 0x73 / 255, blue: 0x00 / 255, alpha: 1)
    })
    
    static let cemailWarningTint = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 0x37 / 255, green: 0x24 / 255, blue: 0x16 / 255, alpha: 1) : UIColor(red: 0xFF / 255, green: 0xE9 / 255, blue: 0xD6 / 255, alpha: 1)
    })
}

nonisolated extension VerifiedIdentityState {
    /// The chip's text, also read to VoiceOver where the chip itself is hidden.
    var title: String {
        switch self {
        case .verified(let realName, _, shownAs: nil):
            realName
        case .verified(let realName, _, shownAs: .some(let shownAs)):
            UntranslatedL10n.commonShownAsVerifiedAs(shownAs, realName)
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
            VerifiedIdentityChip(state: .verified(realName: "Ana Kowalczyk", record: record, shownAs: nil))
            VerifiedIdentityChip(state: .verified(realName: "Ana Kowalczyk", record: record, shownAs: "Alice Chen · CEO"))
            VerifiedIdentityChip(state: .known)
            VerifiedIdentityChip(state: .unverified)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
