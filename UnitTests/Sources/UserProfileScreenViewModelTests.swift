//
// Copyright 2025 Element Creations Ltd.
// Copyright 2022-2025 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

@testable import ElementX
import Testing

@MainActor
struct UserProfileScreenViewModelTests {
    @Test
    func initialState() async throws {
        let userIndicatorController = UserIndicatorControllerMock()
        
        let profile = UserProfile(userID: "@alice:matrix.org", displayName: "Alice", avatarURL: .mockMXCAvatar)
        let clientProxy = ClientProxyMock(.init())
        clientProxy.profileForReturnValue = .success(profile)
        
        let viewModel = UserProfileScreenViewModel(userID: profile.id,
                                                   isPresentedModally: false,
                                                   userSession: UserSessionMock(.init(clientProxy: clientProxy)),
                                                   appHooks: AppHooks(),
                                                   analytics: AnalyticsServiceMock(.init()),
                                                   userIndicatorController: userIndicatorController)
        let context = viewModel.context
        
        let waitForMemberToLoad = deferFulfillment(context.observe(\.viewState.userProfile)) { $0 != nil }
        try await waitForMemberToLoad.fulfill()
        
        #expect(!context.viewState.isOwnUser)
        #expect(context.viewState.userProfile == profile)
        #expect(context.viewState.permalink != nil)
    }
    
    @Test
    func initialStateAccountOwner() async throws {
        let userIndicatorController = UserIndicatorControllerMock()
        
        let profile = UserProfile(userID: RoomMemberProxyMock.mockMe.userID, displayName: "Me", avatarURL: .mockMXCAvatar)
        let clientProxy = ClientProxyMock(.init())
        clientProxy.profileForReturnValue = .success(profile)
        
        let viewModel = UserProfileScreenViewModel(userID: profile.id,
                                                   isPresentedModally: false,
                                                   userSession: UserSessionMock(.init(clientProxy: clientProxy)),
                                                   appHooks: AppHooks(),
                                                   analytics: AnalyticsServiceMock(.init()),
                                                   userIndicatorController: userIndicatorController)
        let context = viewModel.context
        
        let waitForMemberToLoad = deferFulfillment(context.observe(\.viewState.userProfile)) { $0 != nil }
        try await waitForMemberToLoad.fulfill()
        
        #expect(context.viewState.isOwnUser)
        #expect(context.viewState.userProfile == profile)
        #expect(context.viewState.permalink != nil)
    }
    
    @Test
    func startingDmWithUnknownUserFetchesIdentity() async throws {
        let userIndicatorController = UserIndicatorControllerMock()
        
        let profile = UserProfile.mockAlice
        
        let clientProxy = ClientProxyMock(.init())
        clientProxy.directRoomForUserIDReturnValue = .success(nil)
        clientProxy.userIdentityForFallBackToServerReturnValue = .success(nil)
        
        let viewModel = UserProfileScreenViewModel(userID: profile.id,
                                                   isPresentedModally: false,
                                                   userSession: UserSessionMock(.init(clientProxy: clientProxy)),
                                                   appHooks: AppHooks(),
                                                   analytics: AnalyticsServiceMock(.init()),
                                                   userIndicatorController: userIndicatorController)
        
        let context = viewModel.context
        
        let waitForMemberToLoad = deferFulfillment(context.observe(\.viewState.userProfile)) { $0 != nil }
        try await waitForMemberToLoad.fulfill()
        
        let deferred = deferFulfillment(context.observe(\.viewState.bindings).compactMap(\.inviteConfirmationUser), timeout: .seconds(5)) { $0.isUnknown }
        
        context.send(viewAction: .openDirectChat)
        try await deferred.fulfill()
    }
    
    @Test
    func displayNameDifferentFromVerifiedNameIsFlagged() async throws {
        let profile = UserProfile(userID: "@bob:matrix.org", displayName: "Alice Chen · CEO", avatarURL: nil)
        let clientProxy = ClientProxyMock(.init())
        clientProxy.profileForReturnValue = .success(profile)
        let record = VerifiedIdentityRecord(realName: "Bartek Nowak", country: "Poland", verifiedOn: "3 Sep 2026", linkedEmail: "b.nowak@cemail.org")
        
        let viewModel = UserProfileScreenViewModel(userID: profile.id,
                                                   isPresentedModally: false,
                                                   userSession: UserSessionMock(.init(clientProxy: clientProxy)),
                                                   appHooks: AppHooks(),
                                                   analytics: AnalyticsServiceMock(.init()),
                                                   userIndicatorController: UserIndicatorControllerMock(),
                                                   verifiedIdentityService: VerifiedIdentityService(records: [profile.id: record]))
        let context = viewModel.context
        
        let waitForProfile = deferFulfillment(context.observe(\.viewState.verifiedIdentity)) { $0 != .unverified }
        try await waitForProfile.fulfill()
        
        #expect(context.viewState.verifiedIdentity == .verified(realName: "Bartek Nowak", record: record, matchesDisplayName: false))
    }
}
