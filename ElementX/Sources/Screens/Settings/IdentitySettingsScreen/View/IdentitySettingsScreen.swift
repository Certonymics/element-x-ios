//
// Copyright 2026 Element Creations Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Compound
import SwiftUI

struct IdentitySettingsScreen: View {
    @Bindable var context: IdentitySettingsScreenViewModel.Context
    
    var body: some View {
        Form {
            Section {
                ListRow(kind: .custom {
                    VerifiedIdentityChip(state: context.viewState.verifiedIdentity)
                        .padding(ListRowPadding.insets)
                })
            } footer: {
                Text(UntranslatedL10n.screenIdentitySettingsDescription(context.viewState.userID))
                    .compoundListSectionFooter()
            }
            
            if context.viewState.verifiedIdentity.isVerified {
                Section {
                    ListRow(kind: .custom {
                        VerifiedIdentityCard(state: context.viewState.verifiedIdentity, displayName: nil)
                            .padding(.vertical, 8)
                    })
                }
            } else {
                Section {
                    ListRow(label: .centeredAction(title: UntranslatedL10n.actionVerifyWithId, icon: \.verified),
                            kind: .button { context.send(viewAction: .verify) })
                } footer: {
                    Text(UntranslatedL10n.screenIdentitySettingsNotVerifiedDescription)
                        .compoundListSectionFooter()
                }
            }
        }
        .compoundList()
        .navigationTitle(UntranslatedL10n.commonIdentity)
    }
}

// MARK: - Previews

struct IdentitySettingsScreen_Previews: PreviewProvider, TestablePreview {
    static let unverifiedViewModel = IdentitySettingsScreenViewModel(userID: "@me:matrix.org", verifiedIdentityService: VerifiedIdentityService(records: [:]))
    static let verifiedViewModel = IdentitySettingsScreenViewModel(userID: "@me:matrix.org", verifiedIdentityService: .demo(ownUserID: "@me:matrix.org"))
    
    static var previews: some View {
        ElementNavigationStack {
            IdentitySettingsScreen(context: unverifiedViewModel.context)
        }
        .previewDisplayName("Unverified")
        
        ElementNavigationStack {
            IdentitySettingsScreen(context: verifiedViewModel.context)
        }
        .previewDisplayName("Verified")
    }
}
