//
//  chatMessageRow.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import SwiftUI

struct chatMessageRow: View {
    let isUser: Bool
    let message: ReceiveChatMessage
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    var body: some View {
        HStack{
            if isUser{
                Spacer()
            }
            VStack(alignment: .leading, spacing: 6){
                HStack{
                    Text(message.user)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                    
                    Text(Self.dateFormatter.string(from: message.date))
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                Text(message.message)
                
            }
            .foregroundColor(isUser ? .white : .black)
            .padding(10)
            .background(isUser ? .blue : .gray.opacity(0.4))
            .cornerRadius(5)
            if (!isUser)
            {
                Spacer()
            }
        }
    }
}
/*
struct chatMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        chatMessageRow(isUser: true, message: adf)
    }
}
*/
