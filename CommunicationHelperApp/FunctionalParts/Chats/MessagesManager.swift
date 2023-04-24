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

    // Read message from Firestore in real-time with the addSnapShotListener
//    func getMessages(personalId: String) {
//        // TODO: チャットの構成を確定すること。
//        guard let auth = Auth.auth().currentUser?.uid else { return }
//        db.collection("OwnerList").document(auth).collection("ChatRoomId").document(personalId).collection("Chat").addSnapshotListener { querySnapshot, error in
//            // If we don't have documents, exit the function
//            guard let documents = querySnapshot?.documents else {
//                print("Error fetching documents: \(String(describing: error))")
//                return
//            }
//            // Mapping through the documents
//            self.messages = documents.compactMap { document -> Message? in
//                do {
//                    // Converting each document into the Message model
//                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
//                    return try document.data(as: Message.self)
//                } catch {
//                    // If we run into an error, print the error in the console
//                    print("Error decoding document into Message: \(error)")
//                    // Return nil if we run into an error - but the compactMap will not include it in the final array
//                    return nil
//                }
//            }
//            // Sorting the messages by sent date
//            self.messages.sort { $0.timestamp < $1.timestamp }
//            // Getting the ID of the last message so we automatically scroll to it in ContentView
//            if let id = self.messages.last?.id {
//                self.lastMessageId = id
//            }
//        }
//    }
    
    func getMessages(personalId: String) {
        db.collection("OwnerList")
        // TODO: ここはオーナーID、最初の登録時に記録させておく。
            .document("onLqDuEae8asgxF9UtdlFds8Cdg1")
            .collection("ChatRoomId")
        // TODO: ここはWorkerID、朝礼時にQRコードを読んで記録しておく。
            .document("worker_LblN3rJuKgiP6WfrMp86")
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
