//
//  Worker.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Worker: Identifiable, Codable {
    var id: String
    var name: String
    var workerId: String
    var deviceId: String
    // ここのタイムスタンプを更新することで朝礼のスキャンが出来ているかを確認する。
    var timestamp: Date
}

class WorkerSettingManager: ObservableObject {
    @Published private(set) var workers: [Worker] = []
    let db = Firestore.firestore()
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    // TODO: getWorkerDataが取得できない。
    func getWorkerData() {
        guard let ownerId = userDefault.ownerId,
              let deviceId = userDefault.deviceId else { return }
        db.collection("OwnerList").document(ownerId).collection("WorkerData").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("WorkerSettingManager / Error fetching documents: \(String(describing: error))")
                return
            }
            self.workers = documents.compactMap{ document -> Worker? in
                print("hirohiro_a_getWorkerData: ", documents)
                do {
                    if let index = self.workers.firstIndex(where: { $0.deviceId == deviceId }) {
                        self.userDefault.workerId = self.workers[index].workerId
                        self.userDefault.loginDate = Date()
                    }
                    return try document.data(as: Worker.self)
                } catch {
                    print("WorkerSettingManager / Error decoding document into Message: \(error)")
                    return nil
                }
            }
            print("hirohiro_a_workers: ", self.workers, ownerId, deviceId)
        }
    }
}
