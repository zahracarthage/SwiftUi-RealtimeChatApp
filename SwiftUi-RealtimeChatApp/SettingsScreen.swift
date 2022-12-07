//
//  SettingsScreen.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject private var userInfo: userInfo
    var body: some View {
        Form{
            Section(header: Text("Username"))
            {
                TextField("Eg: Zahra Ch", text: $userInfo.username)
                    .disableAutocorrection(true)

                
                NavigationLink("Continue", destination: ChatScreen())
                    .disabled(!isUsernameValid)
            }
        }.navigationTitle("Settings")
    }
    
    private var isUsernameValid: Bool{
        !userInfo.username.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
