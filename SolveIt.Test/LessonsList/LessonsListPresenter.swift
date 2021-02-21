//
//  ClassroomListPresenter.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import Foundation

class LessonsListPresenter {
    
    //MARK:- Private properties
    
    private var lessonsList: [Lesson] = []
    private var filtredLessons: [Lesson] = []
    
    private var dataIsUpdated: Bool = false
    
    private weak var view: LessonsListViewInput!
    
    //MARK:- Completions
    
    private var dataUpdatingCompletion: (() -> ())?
    
    //MARK:- Init
    
    init (withView view: LessonsListViewInput){
        self.view = view
        updateData()
    }
    
    //MARK:- Private functions
    
    private func updateData() {
        
        DataManager.shared.updateData { [weak self] lessons in
            guard let self = self else { return }
            self.lessonsList = lessons
            self.filtredLessons = self.lessonsList
            self.dataIsUpdated = true
            self.dataUpdatingCompletion?()
        } failure: {
            // TODO Something on failure
        }

    }
}

//MARK:- Extension view output

extension LessonsListPresenter: LessonsListViewOutput {
    
    func viewDidLoad() {
        
        if dataIsUpdated == true {
            
            view.loadingView(hidden: true)
            view.lessonsContainerView(hidden: false)
            view.reloadData()
        } else {
            self.dataUpdatingCompletion = { [weak self] in
                guard let self = self else { return }
                
                self.view.loadingView(hidden: true)
                self.view.lessonsContainerView(hidden: false)
                self.view.reloadData()
            }
        }
    }
    
    func numberOfRows() -> Int {
        filtredLessons.count
    }
    
    func cellDataAt(_ indexPath: IndexPath) -> Lesson {
        filtredLessons[indexPath.row]
    }
    
    func filterLessonsWithText(_ text: String) {
        
        if text == ""{
            
            filtredLessons = lessonsList
        } else {
            
            filtredLessons = lessonsList.filter({ (lesson) -> Bool in
                
                let name = lesson.name.lowercased()
                
                if name.contains(text.lowercased()) {
                    return true
                } else {
                    return false
                }
            })
        }
        
        view.reloadData()
    }
}
