//
//  DateFormate+Extension.swift
//  Populaw
//
//  Created by Gaurang on 22/09/21.
//

import Foundation

enum DateFormatHelper: String {
    case fullDateTime   = "MM-dd-yyyy HH:mm"
    case fullDate       = "dd MMMM yyyy"
    case twentyHrTime   = "h:mma"

    var dateFormatter: DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = self.rawValue
        return dateformat
    }

    func getDateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func getDate(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }

}
