//
//  Topic.swift
//  Felix Student
//
//  Created by Mac on 17/04/21.
//

import Foundation
import ObjectMapper

class Topic: Mappable, Identifiable {

    var id = UUID()
    var aid: String = ""
    var batchId: String = ""
    var batchModule: String = ""
    var createdAt: Int64 = 0
    var date: String = ""
    var dateCreatedAt: Int64 = 0
    var remarks: String = ""
    var timeSpent: String = ""
    var timeSpentMints: Int = 0
    var topic: String = ""
    var topicId: String = ""
    var feedbacks: [String: Feedbacks]?
    var presentString: String = ""
    var rating: Int = 0
    var ratingImage: String = ""
    var averageFeedback: Int = 0
    
    init() {
        
    }
    
    init(aid: String, batchId: String, batchModule: String, date: String, dateCreatedAt: Int64, remarks: String, timeSpent: String, timespentmints: Int, topic: String) {
        self.aid = aid
        self.batchId = batchId
        self.batchModule = batchModule
        self.date = date
        self.dateCreatedAt = dateCreatedAt
        self.remarks = remarks
        self.timeSpent = timeSpent
//        self.timeSpentMints = timespentmints
        self.topic = topic
        self.createdAt = Int64(Date().timeIntervalSince1970)
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        aid                 <- map["aid"]
        batchId             <- map["batchId"]
        batchModule         <- map["batchModule"]
        createdAt           <- map["createdAt"]
        date                <- map["date"]
        dateCreatedAt       <- map["dateCreatedAt"]
        remarks             <- map["remarks"]
        timeSpent           <- map["timeSpent"]
        timeSpentMints      <- map["timeSpentMints"]
        topic               <- map["topic"]
        topicId             <- map["topicId"]
        feedbacks           <- map["feedbacks"]
        averageFeedback     <- map["averageFeedback"]
    }
}

class Feedbacks: Mappable, Identifiable {
    var id = UUID()
    var comment: String = ""
    var createdAt: Int64 = 0
    var feedback: String = ""
    var name: String = ""
    var rating: Int = 0
    var uid: String = ""
    
    init() {
        
    }
    
    init(comment: String, feedback: String, rating: Int) {
        self.comment = comment
//        self.createdAt = Int64(Date().timeIntervalSince1970)
        self.name = SessionStore.shared.student?.name ?? ""
        self.rating = rating
        self.uid = SessionStore.shared.user?.uid ?? ""
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        comment         <- map["comment"]
        createdAt       <- map["createdAt"]
        feedback        <- map["feedback"]
        name            <- map["name"]
        rating          <- map["rating"]
        uid             <- map["uid"]
    }
}
