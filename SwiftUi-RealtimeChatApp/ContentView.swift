//
//  ContentView.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var userInfos = userInfo()
    var body: some View {
        NavigationView{
            SettingsScreen()
        }.environmentObject(userInfos)

    }

   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
