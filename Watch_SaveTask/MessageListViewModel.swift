//
//  MessageListViewModel.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/27.
//

import SwiftUI
import WatchConnectivity
import CoreData

final class MessageListViewModel: NSObject, ObservableObject {

    @Published var messagesData: [Memo] = []
    @Environment(\.managedObjectContext) var managedObjectContext

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

        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.managedObjectContext
        guard let messages = try? decoder.decode([Memo].self, from: messageData) else {
            return
        }

        DispatchQueue.main.async {
            self.messagesData = messages
//            messages.forEach { self.saveData(message:$0) }
        }
    }


    func saveData(message: Memo) {
        let newMemo = Memo(context: self.managedObjectContext)
        newMemo.title = message.title
        newMemo.dateAdded = message.dateAdded

        do {
            if managedObjectContext.hasChanges {
                try self.managedObjectContext.save()
            }
        } catch (let err) {
            print("Cannot save newMemo:\(err.localizedDescription)")
        }

    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    func sessionDidDeactivate(_ session: WCSession) {
    }
}
