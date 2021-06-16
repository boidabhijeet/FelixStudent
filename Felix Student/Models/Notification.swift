//
//  Notification.swift
//  Felix Student
//
//  Created by Mac on 03/06/21.
//

import Foundation
import ObjectMapper

class Notification: Mappable {
    var id = UUID()
    var batchId: String = ""
    var body: String = ""
    var mediaUrl: String = ""
    var notificationId: String = ""
    var postedAt: String = ""
    var sendToUid: String = ""
    var title: String = ""
    var type: String = ""
    var readAt: Int = 0
    var readStatus: Bool = false
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        batchId         <- map["batchId"]
        body            <- map["body"]
        mediaUrl        <- map["mediaUrl"]
        notificationId  <- map["notificationId"]
        postedAt        <- map["postedAt"]
        sendToUid       <- map["sendToUid"]
        title           <- map["title"]
        type            <- map["type"]
        readAt          <- map["readAt"]
        readStatus      <- map["readStatus"]
        
    }
    
    
}
