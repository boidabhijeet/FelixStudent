//
//  User.swift
//  Felix Student
//
//  Created by Mac on 24/04/21.
//

import Foundation
import ObjectMapper

class Users: Mappable {
    var id = UUID()
    var branch: String = ""
    var designation: String = ""
    var email: String = ""
    var forSubjects: [String] = []
    var fullName: String = ""
    var isActive: Bool = false
    var isDeveloper: Bool = false
    var mobileNumber: String = ""
    var password: String = ""
    var photoUrl: String = ""
    var uid: String = ""
    var userActiveStatus: Bool = false
    var userType: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        branch              <- map["branch"]
        designation         <- map["designation"]
        email               <- map["email"]
        forSubjects         <- map["forSubjects"]
        fullName            <- map["fullName"]
        isActive            <- map["isActive"]
        isDeveloper         <- map["isDeveloper"]
        mobileNumber        <- map["mobileNumber"]
        password            <- map["password"]
        photoUrl            <- map["photoUrl"]
        uid                 <- map["uid"]
        userActiveStatus    <- map["userActiveStatus"]
        userType            <- map["userType"]
    }
    
    
}
