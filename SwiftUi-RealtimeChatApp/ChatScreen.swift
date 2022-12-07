//
//  ChatScreen.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import SwiftUI

struct ChatScreen: View {
    @StateObject private var chatModel = ChatScreenModel()
    @EnvironmentObject private var userInfo : userInfo
    @State private var message = ""
    private func onAppear() {
        chatModel.connect(username: userInfo.username, userId: userInfo.userID)    }
    private func onDisappear(){
        chatModel.disconnect()
    }
    private func onCommit()
    {
        if !message.isEmpty{
            chatModel.send(text: message)
            message = ""
        }
    }
    var body: some View {
        VStack{
        
            ScrollView{
                ScrollViewReader{ proxy in
                    LazyVStack(spacing: 8){
                        ForEach(chatModel.messages) {
                            message in
                            chatMessageRow(isUser: message.userID == userInfo.userID, message: message)
                                .id(message.id
                                )
                        }
                        
                    }.onChange(of: chatModel.messages.count) {
                        _ in
                        scrollToLastMessage(proxy: proxy)
                    }
                }
            }.padding()
            HStack{
                TextField("Message", text: $message, onEditingChanged: { _ in }, onCommit: onCommit)
                    .autocorrectionDisabled(true)
                                    .padding(10)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(5)
                                
                                Button(action: onCommit) {
                                    Image(systemName: "arrowshape.turn.up.right")
                                        .font(.system(size: 20))
                                        .padding(6)
                                }
                                .cornerRadius(5)
                                .disabled(message.isEmpty)
                                .hoverEffect(.highlight)
            }
            .padding(.horizontal)
        }.onAppear(perform: onAppear)
            .onDisappear(perform: onDisappear)
    }
    private func scrollToLastMessage(proxy: ScrollViewProxy){
        if let lastMessage = chatModel.messages.last {
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
   
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
