//
//  DateUtils.swift
//  movieDB
//
//  Created by Francisco Gindre on 6/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func moviedb_formatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        return dateFormatter
    }
}

extension Date  {
    
    // from 2016-08-18 to 18 de agosto 2016
    static func localizedDate(date: Date) -> String{
        
        return localizedDate(date, timeZone: nil)
        
    }
    
    static func localizedDate(_ date: Date, timeZone: TimeZone? ) -> String{
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        if let tz = timeZone {
            formatter.timeZone = tz
        }
        formatter.formattingContext = .listItem
        formatter.locale = AppEnvironment.shared.locale
        
        return formatter.string(from: date)
        
    }
}

