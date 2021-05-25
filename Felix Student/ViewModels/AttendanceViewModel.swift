//
//  AttendanceViewModel.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.
//

import Foundation
import Combine
import ObjectMapper

class AttendanceViewModel: ObservableObject, Identifiable {
    var id: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        
    }
    
   
}
