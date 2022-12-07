//
//  userInfo.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import Foundation
import Combine

class userInfo: ObservableObject {
    let userID = UUID()
    @Published var username = ""
}
