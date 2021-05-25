//
//  Reference.swift
//  Felix Student
//
//  Created by Mac on 24/04/21.
//

import Foundation
import ObjectMapper

class Reference: Mappable {
    var id = UUID()
    var byName: String = ""
    var contact: String = ""
    var createdAt: Int64 = 0
    var email: String = ""
    var fullName: String = ""
    var rid: String = ""
    var source: String = ""
    var uid: String = ""
    
    init(byName: String, contact: String, createdAt: Int64, email: String, fullName: String, source: String, uid: String) {
        self.byName = byName
        self.contact = contact
        self.createdAt = createdAt
        self.email = email
        self.fullName = fullName
        self.source = source
        self.uid = uid
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        byName      <- map["byName"]
        contact     <- map["contact"]
        createdAt   <- map["createdAt"]
        email       <- map["email"]
        fullName    <- map["fullName"]
        rid         <- map["rid"]
        source      <- map["source"]
        uid         <- map["uid"]
    }
    
    
}
