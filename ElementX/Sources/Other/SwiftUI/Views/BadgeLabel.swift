//
// Copyright 2025 Element Creations Ltd.
// Copyright 2024-2025 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Compound
import SwiftUI

struct BadgeLabel: View {
    enum Style {
        case accent
        case info
        case `default`
        /// Brand colours that have no Compound token, e.g. a partner's identity badge.
        case tinted(text: Color, background: Color)
    }
    
    let title: String
    let icon: KeyPath<CompoundIcons, Image>
    let style: Style
    
    var body: some View {
        Label(title,
              icon: icon,
              iconSize: .xSmall,
              relativeTo: .compound.bodySM)
            .labelStyle(LabelStyle(style: style))
    }
    
    private struct LabelStyle: SwiftUI.LabelStyle {
        let style: Style
        
        var titleColor: Color {
            switch style {
            case .accent: .compound.textBadgeAccent
            case .info: .compound.textBadgeInfo
            case .default: .compound.textPrimary
            case .tinted(let text, _): text
            }
        }
        
        var iconColor: Color {
            switch style {
            case .accent: .compound.iconAccentPrimary
            case .info: .compound.iconInfoPrimary
            case .default: .compound.iconPrimary
            case .tinted(let text, _): text
            }
        }
        
        var backgroundColor: Color {
            switch style {
            case .accent: .compound.bgBadgeAccent
            case .info: .compound.bgBadgeInfo
            case .default: .compound.bgBadgeDefault
            case .tinted(_, let background): background
            }
        }
        
        var borderColor: Color {
            switch style {
            case .default: .compound.borderInteractiveSecondary
            default: .clear
            }
        }
        
        func makeBody(configuration: Configuration) -> some View {
            HStack(spacing: 4) {
                configuration.icon
                    .foregroundStyle(iconColor)
                configuration.title
                    .foregroundStyle(titleColor)
            }
            .font(.compound.bodySM)
            .padding(.leading, 8)
            .padding(.trailing, 12)
            .padding(.vertical, 4)
            .background {
                Capsule().fill(backgroundColor).overlay {
                    Capsule().stroke(borderColor)
                }
            }
        }
    }
}

struct BadgeLabel_Previews: PreviewProvider, TestablePreview {
    static var previews: some View {
        VStack(spacing: 10) {
            BadgeLabel(title: "Encrypted",
                       icon: \.lockSolid,
                       style: .accent)
            BadgeLabel(title: "Not encrypted",
                       icon: \.lockSolid,
                       style: .info)
            BadgeLabel(title: "1234",
                       icon: \.userProfile,
                       style: .default)
            BadgeLabel(title: "Very long text that potentially will wrap around in constrained environments, maybe into two or three lines, depending on the exact length of the text",
                       icon: \.userProfile,
                       style: .default)
        }
    }
}
