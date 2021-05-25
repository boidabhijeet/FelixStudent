//
//  Constants.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.
//

import Foundation

final class Constants {
    
    static let PRODUCTION = "Production"
    static let BATCHES = "batches"
    static let ATTENDANCE_INFO = "attendance_info"
    static let ATTENDANCE = "attendance"
    static let TOPICS = "topics"
    static let REFERENCES = "references"
    static let STUDENT_REFERENCE = "student_references"
    static let FEEDBACKS = "feedbacks"
    static let GENERAL_FEEDBACKS = "general_feedbacks"
    static let USERS = "users"
    static let FACULTY = "faculty"
    static let ROLE = "role"
    static let STUDENT = "student"
    static let WALKINS = "walkins"
    static let UID = "uid"
    static let FACULTYUID = "facultyUid"
    static let LEADID = "leadId"
    static let BATCHTYPE = "batchType"
    static let ONGOING = "Ongoing"
}

final class ToastAlert {
    static let attendanceMarked = "Attendance for current date has been already marked"
}


final class Utility {
    static func getRole() -> String  {
        if let role = UserDefaults.standard.value(forKey: Constants.ROLE) {
            return role as! String
        }
        return ""
    }
}
