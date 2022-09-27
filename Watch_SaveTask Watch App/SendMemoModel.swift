//
//  SendMemoModel.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/26.
//

import WatchConnectivity

final class SendMemoModel: NSObject {
//    static let shared = SendMemoModel()
    var session: WCSession

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension SendMemoModel: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("The session has completed activation.")
        }
    }
}

//extension SendMemoModel {
//
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        // メインスレッドで処理
//        DispatchQueue.main.async {
//            let receivedAnimal = message["title"] as? String ?? "UMA"
//            let receivedEmoji = message["dateAdded"] as? Date ?? Date()
//            print(receivedEmoji)
//        }
//    }
//}
