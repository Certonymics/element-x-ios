//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Compound
import SwiftUI

/// The Passport card: what the government-issued ID verified. Empty unless the user is verified.
struct VerifiedIdentityCard: View {
    let state: VerifiedIdentityState
    let displayName: String?
    
    var body: some View {
        if case .verified(let realName, let record, let matchesDisplayName) = state {
            VStack(alignment: .leading, spacing: 12) {
                Label(UntranslatedL10n.commonVerifiedIdentity, icon: \.verified, iconSize: .small, relativeTo: .compound.bodyMDSemibold)
                    .font(.compound.bodyMDSemibold)
                    .foregroundStyle(.compound.textPrimary)
                
                if !matchesDisplayName, let displayName {
                    Label(UntranslatedL10n.commonShownAsVerifiedAs(displayName, realName), icon: \.warning, iconSize: .xSmall, relativeTo: .compound.bodySM)
                        .font(.compound.bodySMSemibold)
                        .foregroundStyle(.compound.textCriticalPrimary)
                }
                
                row(UntranslatedL10n.commonRealName, value: realName)
                row(UntranslatedL10n.commonVerifiedWith, value: UntranslatedL10n.commonGovernmentIssuedId)
                if let country = record.country {
                    row(UntranslatedL10n.commonCountry, value: country)
                }
                if let verifiedOn = record.verifiedOn {
                    row(UntranslatedL10n.commonVerifiedOn, value: verifiedOn)
                }
                if let linkedEmail = record.linkedEmail {
                    row(UntranslatedL10n.commonLinkedEmail, value: linkedEmail)
                }
                
                Text(UntranslatedL10n.screenUserProfileVerifiedIdentityFooter)
                    .font(.compound.bodySM)
                    .foregroundStyle(.compound.textSecondary)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.compound.bgSubtleSecondary, in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 16)
        }
    }
    
    private func row(_ title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(title)
                .foregroundStyle(.compound.textSecondary)
            Spacer()
            Text(value)
                .foregroundStyle(.compound.textPrimary)
                .multilineTextAlignment(.trailing)
        }
        .font(.compound.bodyMD)
    }
}

struct VerifiedIdentityCard_Previews: PreviewProvider, TestablePreview {
    static let record = VerifiedIdentityRecord(realName: "Ana Kowalczyk", country: "Poland", verifiedOn: "12 Aug 2026", linkedEmail: "a.kowalczyk@cemail.org")
    
    static var previews: some View {
        VStack(spacing: 16) {
            VerifiedIdentityCard(state: .verified(realName: "Ana Kowalczyk", record: record, matchesDisplayName: true), displayName: "Ana Kowalczyk")
            VerifiedIdentityCard(state: .verified(realName: "Ana Kowalczyk", record: record, matchesDisplayName: false), displayName: "Alice Chen · CEO")
        }
        .previewLayout(.sizeThatFits)
    }
}
