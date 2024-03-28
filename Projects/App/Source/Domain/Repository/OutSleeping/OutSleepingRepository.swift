//
//  OutSleepingRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol OutSleepingRepository {
    
    func postOutSleeping(_ request: PostOutSleepingRequest) async throws
    
    func deleteOutSleeping(id: Int) async throws
    
    func fetchOutSleeping() async throws -> [OutSleepingResponse]
}
