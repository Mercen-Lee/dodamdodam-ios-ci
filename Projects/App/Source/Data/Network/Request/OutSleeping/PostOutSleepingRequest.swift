//
//  PostOutSleepingRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct PostOutSleepingRequest: RequestProtocol {
    
    let reason: String
    let startAt: String
    let endAt: String
}
