//
//  Models.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import Foundation

struct SubmittedChatMessage: Encodable {
    let message: String
    let user: String
    let userID: UUID
}

struct ReceiveChatMessage: Decodable, Identifiable{
    let date = Date()
    let id = UUID()
    let message : String
    let user: String
    let userID: UUID
}

