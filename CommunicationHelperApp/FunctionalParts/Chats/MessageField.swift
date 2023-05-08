//
//  MessageField.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/05/08.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var messagesManager: MessagesManager
    @State private var message = ""
    @State private var pulseRat: Float = 0
    @State private var openView: Bool = false

    var body: some View {
        HStack {
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
    }
}
