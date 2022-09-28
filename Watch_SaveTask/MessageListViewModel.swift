//
//  MessageListViewModel.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/27.
//

import SwiftUI
import WatchConnectivity

final class MessageListViewModel: NSObject, ObservableObject {

    @Published var messagesData: [String] = []
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
//
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        // メインスレッドで処理
//        print(message)
//        let jsonDecoder = JSONDecoder()
//        //decodeする
//        do {
//            let data = message
//        }

//        DispatchQueue.main.async {
//            let title = message["title"] as? String ?? "UMA"
//            let dateAdded = message["dateAdded"] as? Date ?? Date()
//            let data = Memo()
//            data.title = title
//            data.dateAdded = dateAdded
//
//            JSONEncoder().encode(data)
//
//            let decoder = JSONDecoder()
//            decoder.userInfo[CodingUserInfoKey(rawValue: "managedObjectContext")!] = self.managedObjectContext
//            let memo = try decoder.decode([Memo].self, from: data)
//        }
//    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        DispatchQueue.main.async {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey(rawValue: "managedObjectContext")!] = self.moc
            guard let messages = try? decoder.decode([Memo].self, from: messageData) else {
                return
            }
            
            for message in messages {
                print(message.title)
                self.messagesData.append(message.title!)
            }

        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    func sessionDidDeactivate(_ session: WCSession) {
    }
}
