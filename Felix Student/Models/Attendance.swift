//
//  Attendance.swift
//  Felix Student
//
//  Created by Mac on 17/04/21.
//

import Foundation
import FirebaseFirestore
import ObjectMapper

class Attendance: Identifiable, Mappable {
    
    var id = UUID()
    var aid: String = ""
    var batchId: String = ""
    var batchModule: String = ""
    var remark:String = ""
    var totalTimeSpent: String = ""
    var totalTimeSpentMints: Int = 0
    var markAttendance: [String: Bool] = [:]
    var confirmAttendance: [String: Bool] = [:]
    var createdAt: Int64!
    
    init() {
        
    }
    
    
    init(batchId: String, batchModule: String, remark: String, totalTimeSpent: String, totalTimeSpentMints: Int, markAttendance: [String: Bool], createdAt: Int64) {
        self.batchId = batchId
        self.batchModule = batchModule
        self.remark = remark
        self.totalTimeSpent = totalTimeSpent
        self.totalTimeSpentMints = totalTimeSpentMints
        self.markAttendance = markAttendance
        self.createdAt = createdAt
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        aid                  <- map["aid"]
        batchId              <- map["batchId"]
        batchModule          <- map["batchModule"]
        remark               <- map["remark"]
        totalTimeSpent       <- map["totalTimeSpent"]
        totalTimeSpentMints  <- map["totalTimeSpentMints"]
        markAttendance       <- map["markAttendance"]
        confirmAttendance    <- map["confirmAttendance"]
        createdAt            <- map["createdAt"]
    }
}
