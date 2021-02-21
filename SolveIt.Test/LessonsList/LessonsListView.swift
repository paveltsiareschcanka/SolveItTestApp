//
//  ClassroomListView.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import UIKit

protocol LessonsListViewInput: AnyObject {
    func reloadData()
    func lessonsContainerView(hidden: Bool)
    func loadingView(hidden: Bool)
}

protocol LessonsListViewOutput: AnyObject {
    func viewDidLoad()
    func numberOfRows() -> Int
    func cellDataAt(_ indexPath: IndexPath) -> Lesson
    func filterLessonsWithText(_ text: String)
}

class LessonsListView: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet private weak var lessonsContainerView: UIView!
    
    @IBOutlet private weak var headerTitle: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var lessonsTable: UITableView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Public Properties
    
    var presenter: LessonsListViewOutput!
    
    //MARK:- Lifcycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupView()
        setupTextField()
        presenter.viewDidLoad()
    }
    
    //MARK:- Setups
    
    private func setupTableView() {
        
        lessonsTable.delegate = self
        lessonsTable.dataSource = self
        lessonsTable.separatorStyle = .none
        
        let lessonCellNib = UINib(nibName: "LessonCell", bundle: nil)
        lessonsTable.register(lessonCellNib, forCellReuseIdentifier: "LessonCell")
    }
    
    private func setupView() {
        
        activityIndicator.hidesWhenStopped = true
        
        loadingView(hidden: false)
        lessonsContainerView(hidden: true)
        
        headerTitle.text = NSLocalizedString("LessonsListVC.header.title", comment: "")
        
    }
    
    private func setupTextField() {
        
        searchTextField.delegate = self
        searchTextField.placeholder = NSLocalizedString("Search", comment: "")
    }
}

//MARK:- Extension view input

extension LessonsListView: LessonsListViewInput {
    
    func lessonsContainerView(hidden: Bool) {
        lessonsContainerView.isHidden = hidden
    }
    
    func loadingView(hidden: Bool) {
        
        if hidden == true {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    func reloadData() {
        lessonsTable.reloadData()
    }
}

//MARK:- Extension UITableViewDelegate, UITableViewDataSource

extension LessonsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lessonCell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        lessonCell.data = presenter.cellDataAt(indexPath)
        
        return lessonCell
    }
}

//MARK:- Extension UITextFieldDelegate

extension LessonsListView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        presenter.filterLessonsWithText(textField.text ?? "")
        
        return false
    }
}
