//
//  TimeConverter.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import Foundation

class TitlesConverter {
    
    static func getTimeTitleFrom(_ timeStamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return NSLocalizedString("TitlesConverter.timeTitle.today", comment: "")
        } else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            return NSLocalizedString("TitlesConverter.timeTitle.lastUpdate", comment: "") + " " + formatter.string(from: date)
        }
    }
    
    static func getStatusTitleFrom(_ lessonStatus: String) -> String {
        
        switch lessonStatus {
        
        case "inProgress": return NSLocalizedString("TitlesConverter.status.inProgress", comment: "")
        case "notStarted": return NSLocalizedString("TitlesConverter.status.notStarted", comment: "")
        case "completed": return NSLocalizedString("TitlesConverter.status.completed", comment: "")
        default: return ""
            
        }
    }
}
