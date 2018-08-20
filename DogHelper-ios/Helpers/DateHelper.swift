//
//  DateHelper.swift
//  G12
//
//  Created by Кирилл on 14.04.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class DateHelper {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()
    
    static func ddMMyyyy(_ date: Date = Date()) -> String {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func ddMMyyyy(_ timeInterval: Double?) -> String? {
        guard let timeInterval = timeInterval else { return nil }
        let date = Date(timeIntervalSince1970: timeInterval)
        //222dateFormatter.dateFormat = "dd, MM, yyyy"
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    static func EEEEMMMdyyyy(_ date: Date = Date()) -> String {
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
