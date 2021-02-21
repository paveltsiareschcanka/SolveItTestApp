//
//  DataManager.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import Foundation


class DataManager {
    
    private let queue = DispatchQueue(label: "DataManagerQueue", qos: .background)
    
    static let shared = DataManager()
    
    private init() {}
    
    func updateData(sucsess: @escaping (([Lesson]) -> ()), failure: @escaping (() -> ())) {
        
        queue.async {
            
            let lastUpdate = UserDefaults.standard.getLastUpdateTime()
            let savedLessons = UserDefaults.standard.getLessons()
            
            if lastUpdate != nil && savedLessons != nil {
                
                let currentTimeStamp = Date().timeIntervalSince1970
                
                if Int(currentTimeStamp) - lastUpdate! < 86400 {
                    
                    DispatchQueue.main.async {
                        sucsess(savedLessons!)
                    }
                } else {
                    self.getDataFromBundleAndSave(sucsess: sucsess, failure: failure)
                }
            } else {
                self.getDataFromBundleAndSave(sucsess: sucsess, failure: failure)
            }
        }
    }
    
    private func getDataFromBundleAndSave(sucsess: @escaping (([Lesson]) -> ()), failure: @escaping (() -> ())) {
        
        let url = Bundle.main.url(forResource: "Data", withExtension: "json")!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let data = try? Data(contentsOf: url),
           let lessons = try? decoder.decode([Lesson].self, from: data) {
            
            let currentTimeStamp = Date().timeIntervalSince1970
            
            UserDefaults.standard.setLastUpdateTime(Int(currentTimeStamp))
            UserDefaults.standard.setLessons(lessons)
            
            DispatchQueue.main.async {
                sucsess(lessons)
            }
        } else {
            
            DispatchQueue.main.async {
                failure()
            }
        }
    }
}
