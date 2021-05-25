//
//  Extensions.swift
//  Felix Student
//
//  Created by Mac on 21/05/21.
//

import Foundation

extension Date {

    func getFormattedDate(format: String) -> String {
         let dateformat = DateFormatter()
         dateformat.dateFormat = format
         return dateformat.string(from: self)
     }

}
