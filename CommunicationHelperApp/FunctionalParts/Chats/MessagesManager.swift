//
//  MessagesManager.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    var pulseRate: Float = 0
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    func getMessages(personalId: String) {
        guard let ownerId = userDefault.ownerId,
        let workerId = userDefault.workerId else { return }
        db.collection("OwnerList")
            .document(ownerId)
            .collection("ChatRoomId")
            .document(workerId)
            .collection("Chat").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
            self.messages.sort { $0.timestamp < $1.timestamp }
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }

    func deleteMessage(personalId: String) {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        db.collection("OwnerList").document(auth).collection("ChatRoomId").document(personalId).delete()
    }
}
