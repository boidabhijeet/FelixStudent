// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   var welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import ObjectMapper

class Batch: Mappable, Identifiable {
    var id = UUID()
    var batchDaysType = "", batchId: String = ""
    var batchProgress: Int = 0
    var batchType = "", branch: String = ""
    var createdAt: Int = 0
    var faculty = "", facultyUid: String = ""
    var feedbackChecklist: [Checklist] = []
    var feedbackPercentage: Int = 0
    var feesAlert: Bool = false
    var feesCollection: [Any] = []
    var feesPercentage: Int = 0
    var fromDateString = "", fromTime = "", fromToTime: String = ""
    var hrChecklist: [Checklist] = []
    var hrPercentage: Int = 0
    var isCompleted = false, isOnGoing: Bool = false
    var marketingChecklist: [Checklist] = []
    var module: String = ""
    var students: [String] = []
    var techChecklist: [Checklist] = []
    var techPercentage: Int = 0
    var toDateString = "", toTime: String = ""
    var totalHours = ""
    
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        batchDaysType      <- map["batchDaysType"]
        batchId            <- map["batchId"]
        batchProgress      <- map["batchProgress"]
        batchType          <- map["batchType"]
        branch             <- map["branch"]
        createdAt          <- map["createdAt"]
        faculty            <- map["faculty"]
        facultyUid         <- map["facultyUid"]
        feedbackChecklist  <- map["feedbackChecklist"]
        feedbackPercentage <- map["feedbackPercentage"]
        feesAlert          <- map["feesAlert"]
        feesCollection     <- map["feesCollection"]
        feesPercentage     <- map["feesPercentage"]
        fromDateString     <- map["fromDateString"]
        fromTime           <- map["fromTime"]
        fromToTime         <- map["fromToTime"]
        hrChecklist        <- map["hrChecklist"]
        hrPercentage       <- map["hrPercentage"]
        isCompleted        <- map["isCompleted"]
        isOnGoing          <- map["isOnGoing"]
        marketingChecklist <- map["marketingChecklist"]
        module             <- map["module"]
        students           <- map["students"]
        techChecklist      <- map["techChecklist"]
        techPercentage     <- map["techPercentage"]
        toDateString       <- map["toDateString"]
        toTime             <- map["toTime"]
    }
}

// MARK: - Checklist
class Checklist: Mappable {
    var key: String = ""
    var value: Bool = false
    
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        key   <- map["key"]
        value <- map["value"]
    }
    
}

