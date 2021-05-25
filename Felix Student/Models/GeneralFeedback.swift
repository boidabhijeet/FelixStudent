//
//  GeneralFeedback.swift
//  Felix Student
//
//  Created by Mac on 24/04/21.
//

import Foundation
import ObjectMapper

class GeneralFeedback: Mappable {
    var id = UUID()
    var byName: String = ""
    var createdAt: Int64 = 0
    var fid: String = ""
    var rating: String = ""
    var reply: String = ""
    var title: String = ""
    var uid: String = ""
    
    init(byName: String, rating: String, reply: String, title: String, uid: String) {
        self.byName = byName
        self.createdAt = Int64(NSDate().timeIntervalSince1970)
        self.rating = rating
        self.reply = reply
        self.title = title
        self.uid = uid
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        byName      <- map["byName"]
        createdAt   <- map["createdAt"]
        fid         <- map["fid"]
        rating      <- map["rating"]
        reply       <- map["reply"]
        title       <- map["title"]
        uid         <- map["uid"]
    }
    
    
}
