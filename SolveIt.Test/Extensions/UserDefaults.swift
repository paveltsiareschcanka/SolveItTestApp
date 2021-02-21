//
//  UserDefaults.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import Foundation

extension UserDefaults {
    
    func setLessons(_ lessons: [Lesson]) {
        
        let data = try? JSONEncoder().encode(lessons)
        set(data, forKey: "lessons")
    }
    
    func getLessons() -> [Lesson]? {
        
        if let data = value(forKey: "lessons") as? Data {
            return try? JSONDecoder().decode([Lesson].self, from: data)
        }
        
        return nil
    }
    
    func setLastUpdateTime(_ timeStamp: Int) {
        
        set(timeStamp, forKey: "lastUpdate")
    }
    
    func getLastUpdateTime() -> Int? {
        
        let lastUpdate = value(forKey: "lastUpdate") as? Int
        return lastUpdate
    }
    
}
