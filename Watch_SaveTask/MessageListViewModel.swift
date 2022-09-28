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
    @Environment(\.managedObjectContext) var moc
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
    func isSupported() -> Bool {
        return WCSession.isSupported()
    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        DispatchQueue.main.async {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.moc
            guard let messages = try? decoder.decode([Memo].self, from: messageData) else {
                return
            }
            self.messagesData = messages
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    func sessionDidDeactivate(_ session: WCSession) {
    }
}
