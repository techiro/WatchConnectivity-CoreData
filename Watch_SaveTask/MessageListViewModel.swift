//
//  MessageListViewModel.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/27.
//

import SwiftUI
import WatchConnectivity

final class MessageListViewModel: NSObject, ObservableObject {

    @Published var messagesData: [Memo] = []

    var session: WCSession

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension MessageListViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("The session has completed activation.")
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // メインスレッドで処理
        DispatchQueue.main.async {
            let receivedAnimal = message["title"] as? String ?? "UMA"
            let receivedEmoji = message["dateAdded"] as? Date ?? Date()
            print(receivedAnimal)

        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    func sessionDidDeactivate(_ session: WCSession) {
    }
}
