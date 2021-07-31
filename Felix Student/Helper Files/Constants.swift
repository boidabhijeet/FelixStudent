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
    static let FACULTY = "Faculty"
    static let ROLE = "role"
    static let STUDENT = "Student"
    static let WALKINS = "walkins"
    static let UID = "uid"
    static let FACULTYUID = "facultyUid"
    static let LEADID = "leadId"
    static let BATCHTYPE = "batchType"
    static let ONGOING = "Ongoing"
    static let NOTIFICATIONS = "notifications"
    static let PlaceholderImage = "https://firebasestorage.googleapis.com/v0/b/felixsales-16194.appspot.com/o/Development%2Fuser_photos%2Fuser-default-grey.png?alt=media&token=1541e9d9-cb6d-4208-b0ef-c537ee719a7d"
}

final class ToastAlert {
    static let AtLeastOne = "Please add at least one topic."
    static let FutureDate = "You can not mark attendance for future date."
    static let attendanceMarked = "Attendance for current date has been already marked"
    static let referAndEarn = "Contact information is submitted."
    static let felixFeedback = "Your feedback is submitted."
    static let profileChanged = "Profile updated successfully."
    static let userNotfound = "User not found"
    static let feedbackError = "Please enter issues or ideas."
    static let FullNameError = "Please enter valid name."
    static let contactError = "Please enter valid contact number."
    static let emailError = "Please enter valid email."
    static let studentFeedbackError = "Please select any feedback."
    static let commentError = "Please enter your comment."
}


final class Utility {
    static var fromFeedbackScreen = false
    static func getRole() -> String  {
        if let role = UserDefaults.standard.value(forKey: Constants.ROLE) {
            return role as! String
        }
        return ""
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
