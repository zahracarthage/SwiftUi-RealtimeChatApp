//
//  ChatScreenModel.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import Foundation
import Combine

final class ChatScreenModel : ObservableObject{
    private var username: String?
    private var userId: UUID?
    
    @Published private(set) var messages: [ReceiveChatMessage] = []
    private var webSocketTask: URLSessionWebSocketTask?
    
    func connect(username: String, userId: UUID){
        self.username = username
        self.userId = userId
        let url = URL(string: "ws://127.0.0.1:8080/chat")! // 3
        webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
                webSocketTask?.receive(completionHandler: onReceive) // 5
                webSocketTask?.resume() // 6
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>)
    {
        webSocketTask?.receive(completionHandler: onReceive)
        if case .success(let message) = incoming {
            onMessage(message: message)
        }
        else if case .failure(let error) = incoming {
            print("Error",error)
        }
        
    }
    
    private func onMessage(message :  URLSessionWebSocketTask.Message)
    {
        if case .string(let text) = message { // 5
                guard let data = text.data(using: .utf8),
                        let chatMessage = try? JSONDecoder().decode(ReceiveChatMessage.self, from: data)
                else {
                    return
                }

                DispatchQueue.main.async { // 6
                    self.messages.append(chatMessage)
                }
            }
        
    }
    deinit {
        disconnect()
    }
    
    func send(text: String){
        guard let username = username, let userId = userId else {return}
        let message = SubmittedChatMessage(message: text, user: username, userID: userId)
        guard let json = try? JSONEncoder().encode(message),
              let jsonString = String(data: json, encoding : .utf8)
        else {return}
        
        webSocketTask?.send(.string(jsonString))
        {
            error in
            if let error = error {
                print("Error sending a message", error)
            }
        }
    }
}
