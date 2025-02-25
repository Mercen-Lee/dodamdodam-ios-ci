//
//  AllViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import Combine
import SignKit

class AllViewModel: ObservableObject {
    
    // MARK: - State
    @Published var memberData: MemberResponse?
    @Published var isShowingLogoutAlert: Bool = false
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        
        await fetchMemberData()
    }
    
    @MainActor
    func fetchMemberData() async {
        
        do {
            memberData = try await memberRepository.fetchInfo()
        } catch let error {
            print(error)
        }
    }
    
    func logout() {
        
        isShowingLogoutAlert.toggle()
        Sign.logout()
    }
}
