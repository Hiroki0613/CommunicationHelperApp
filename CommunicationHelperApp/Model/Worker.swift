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

    // TODO: getWorkerDataがリアルタイムで取得できない。
    // TODO: userDefaults.workerIDと同じ内容をstaffでも用意する。そして、getStaffData()として、WorkerTopViewのonAppearで呼び出す。そうすることで、userDefaultsはどちらかのデータが入ってくる。ただし、この場合はpersonalIdと変更した方が使い勝手が良さそうではある・・・。
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
                    return try document.data(as: Worker.self)
                } catch {
                    print("WorkerSettingManager / Error decoding document into Message: \(error)")
                    return nil
                }
            }
            // TODO: バグ。deviceIdが重複した場合の処理が入ってない。この処理の前に、workerIdに"worker_"が含まれているかを条件処理に入れることで解決出来そう。いや無理だ・・・。一気にデータを取ったほうがよさそう。
            /*
             1. OwnerList-PersonalData-WorkerData
                OwnerList-PersonalData-StaffData
                の2つを用意する。
             2. データを一気に取得する。その上で、どちらを取得しているかを判定する。
             3. ここで一気にpushTokenをarrayにセット出来たら通信回数を節約できそう。
                (具体的にどのようにするかは検討が必要)
             */
            if let index = self.workers.firstIndex(where: { $0.deviceId == deviceId }) {
                self.userDefault.workerId = self.workers[index].workerId
                self.userDefault.loginDate = Date()
            }
            print("hirohiro_a_workers: ", self.workers, ownerId, deviceId)
        }
    }
}
