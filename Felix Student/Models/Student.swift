//
//  Student.swift
//  Felix Student
//
//  Created by Mac on 17/04/21.
//

import Foundation
import ObjectMapper

class Student: Mappable, Identifiable {
    
    var id = UUID()
    var totalFee: String = ""
    var walkin: String = ""
    var activeStatus: Bool = false
    var address: String = ""
    var assignedHistory: [String] = []
    var assignedTo: String = ""
    var assignedToName: String = ""
    var branch: String = ""
    var callingDisposition: String = ""
    var closeStatus: Bool = false
    var contact: Int64 = 0
    var courseInterested: String = ""
    var createdAt: Int64 = 0
    var discountOffered: String = ""
    var dob: String = ""
    var email: String = ""
    var employerName: String = ""
    var enrolledAt: Int64 = 0
    var enrolledBy: String = ""
    var enrolledByUid: String = ""
    var felixCenter: String = ""
    var firstCallAt: Int64 = 0
    var firstCaller: String = ""
    var followup: Int64 = 0
    var followupDate: String = ""
    var instituteName: String = ""
    var interestedCourse: String = ""
    var isAssigned: Bool = false
    var isEmployed: Bool = false
    var isFresh: Bool = false
    var isInPipeline: Bool = false
    var isPendingCounselling: Bool = false
    var lastActionBy: String = ""
    var lastActionDate: Int64 = 0
    var leadId: String = ""
    var leadStatus: String = ""
    var location: String = ""
    var name: String = ""
    var pg: String = ""
    var priority: String = ""
    var qualification: String = ""
    var reason: String = ""
    var remark: String = ""
    var revenueFees: Int = 0
    var shouldIncreaseCount: Bool = false
    var source: String = ""
    var timeSpent: Int = 0
    var totalFees: Int = 0
    var updatedAt: Int64 = 0
    var walkedinAt: Int64 = 0
    var walkinStatus: String = ""
    var whereDidYouFindUs: String = ""
    var batchId: String = ""
    var photoUrl: String = ""
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id                                      <- map["id"]
        totalFee                                <- map["totalFee"]
        walkin                                  <- map["walkin"]
        activeStatus                            <- map["activeStatus"]
        address                                 <- map["address"]
        assignedHistory                         <- map["assignedHistory"]
        assignedTo                              <- map["assignedTo"]
        assignedToName                          <- map["assignedToName"]
        branch                                  <- map["branch"]
        callingDisposition                      <- map["callingDisposition"]
        closeStatus                             <- map["closeStatus"]
        contact                                 <- map["contact"]
        courseInterested                        <- map["courseInterested"]
        createdAt                               <- map["createdAt"]
        discountOffered                         <- map["discountOffered"]
        dob                                     <- map["dob"]
        email                                   <- map["email"]
        employerName                            <- map["employerName"]
        enrolledAt                              <- map["enrolledAt"]
        enrolledBy                              <- map["enrolledBy"]
        enrolledByUid                           <- map["enrolledByUid"]
        felixCenter                             <- map["felixCenter"]
        firstCallAt                             <- map["firstCallAt"]
        firstCaller                             <- map["firstCaller"]
        followup                                <- map["followup"]
        followupDate                            <- map["followupDate"]
        instituteName                           <- map["instituteName"]
        interestedCourse                        <- map["interestedCourse"]
        isAssigned                              <- map["isAssigned"]
        isEmployed                              <- map["isEmployed"]
        isFresh                                 <- map["isFresh"]
        isInPipeline                            <- map["isInPipeline"]
        isPendingCounselling                    <- map["isPendingCounselling"]
        lastActionBy                            <- map["lastActionBy"]
        lastActionDate                          <- map["lastActionDate"]
        leadId                                  <- map["leadId"]
        leadStatus                              <- map["leadStatus"]
        location                                <- map["location"]
        name                                    <- map["name"]
        pg                                      <- map["pg"]
        priority                                <- map["priority"]
        qualification                           <- map["qualification"]
        reason                                  <- map["reason"]
        remark                                  <- map["remark"]
        revenueFees                             <- map["revenueFees"]
        shouldIncreaseCount                     <- map["shouldIncreaseCount"]
        source                                  <- map["source"]
        timeSpent                               <- map["timeSpent"]
        totalFees                               <- map["totalFees"]
        updatedAt                               <- map["updatedAt"]
        walkedinAt                              <- map["walkedinAt"]
        walkinStatus                            <- map["walkinStatus"]
        whereDidYouFindUs                       <- map["whereDidYouFindUs"]
        batchId                                 <- map["batchId"]
        photoUrl                                <- map["photoUrl"]
    }
}
