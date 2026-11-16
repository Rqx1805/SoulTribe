//
//  SocketIoManager.swift
//  HowLit
//
//  Created by Tarun Nagar on 04/09/18.
//  Copyright © 2018 Tarun Nagar. All rights reserved.
//

import UIKit
import SocketIO
class SocketIoManager: NSObject {
    
    static let one_to_one_sharedInstance = SocketIoManager()
    
    let manager : SocketManager
    var socket: SocketIOClient
    
//    var URL_Link = "http://i.devtechnosys.tech:17321/"//Live
    var URL_Link = "https://soultribenow.com:17320/"//Live
    

    //var URL_Link = "http://192.168.1.48:17321/"//Demo
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: self.URL_Link)!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
    }
    func establishConnection() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected1111")
        }
        socket.on("currentAmount") {data, ack in
            guard let cur = data[0] as? Double else { return }
            
            self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                self.socket.emit("update", ["amount": cur + 2.50])
            }
            ack.with("Got your currentAmount", "dude")
        }
        socket.connect()
    }
    func closeConnection() {
        socket.disconnect()
    }
    func removeAllHandlers(){
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }
    func connectToServerWithRoom(nickname: String) {
        print("socket emit:-")
        var dict = [String: Any]()
        dict = ["room": RId,"userid": lid]
        
        socket.emit("joinroom", with: [dict as AnyObject])
        self.getChatMessage()
        //self.getoldMessage()
    }
    func connectToServerWithRoom1(nickname: [Any]) {
        print("socket emit:-")
        socket.emit("joinroom", with: nickname)
        self.getChatMessage()
        //self.getoldMessage()
    }
    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false
    }
    
    func getoldMessage() {
           socket.on("getMessage") { ( dataArray, ack) -> Void in
               print(dataArray)
               //            var userid = String()
               //            var msg = String()
               //
               //            userid = (dataArray[0] as! String as AnyObject) as! String
               //            msg = (dataArray[1] as! String as AnyObject) as! String
               //
               //            let chatDict = NSMutableDictionary()
               //            chatDict.setObject(userid, forKey: "user_id" as NSCopying)
               //            chatDict.setObject(msg, forKey: "message" as NSCopying)
               //
               //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: chatDict, userInfo: nil)
               //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudent"), object: dataArray[0], userInfo: nil)
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "new_message_coming"), object: dataArray[0], userInfo: nil)
               
               //            print(userid,msg)
               //            print(dataArray)
               //            print(ack)
               //completionHandler( dataArray[0] as? [String: AnyObject])
           }
       }
    
    func getChatMessage() {
        socket.on("newChatMessage") { ( dataArray, ack) -> Void in
            let dict = DataManager.getVal(dataArray[0]) as! NSDictionary
            print(dict)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "new_message_coming"), object: dict, userInfo: nil)
        }
    }
    func sendMessage( message: String, withRoom room: String,withSender sender_id: String,type: String,vibe:String, message_type:String,withReciver reciever_id: String,mime_type: String,created_at: String) {
        var dict = [String: Any]()
        dict = ["message": message,"room": room,"sender_id" :sender_id,"type": type,"vibe":vibe,"message_type": message_type,"receiver_id": reciever_id,"mime_type":mime_type,"created_at": created_at]
        print("Socket Emit Data",dict)
        socket.emit("chatMessage",with: [dict])
    }
}

