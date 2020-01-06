//
//  WSPViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 10/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

class WSPViewController: UIViewController {
    
    var localStepsArray = [Step]()
    var cdStepsArray = [StepMO]()
    var questionArray = [QuestionMO]()
    var answeredQuestions = [QuestionMO]()
    var numberOfQuestionsInStep = 0
    var currentStepNumber = 0
    var currentQuestionNumber = 0
    
    var logbookItem: FormMO?
    let context = CoreDataStack.instance.managedObjectContext
    var isNewLogbookItem: Bool = true
    @IBOutlet weak var wspTitleLabel: UILabel!
    
    private lazy var questionsView : UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var backAndForwardBar: ButtonBarView = {
        var view = ButtonBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(questionsView)
        view.addSubview(backAndForwardBar)
        questionsView.register(UINib(nibName: "WSPTableViewCell", bundle: nil), forCellReuseIdentifier: "WSPCell")
        setupConstraints()
        
        if isNewLogbookItem {
            logbookItem = FormMO(context: context)
            logbookItem?.createdAt = Date()
        }
        
        
        
        //        CoreDataStack.instance.fetchForms()
        //        let WSPs = CoreDataStack.instance.fetchedWSPs
        //
        //        self.getSteps(basedOn: WSPs) { (success, stepArray, error) in
        //            if error == nil {
        //                if let question = stepArray?[0].question {
        //                    let test = question.map({$0}) as! [QuestionMO]
        //                    debugPrint(test.first?.particularities)
        //                }
        //            }
        //        }
        
        getQuestions { (success, localForm, cdForm, error) in
            if error == nil {
                guard let localForm = localForm else { return }
                self.localStepsArray = localForm.steps
                self.setupForm()
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupForm () {
        
        for questionTitle in localStepsArray[self.currentStepNumber].questionTitles {
            let question = QuestionMO(context: context)
            
            question.title = questionTitle
            question.order = Int32(currentQuestionNumber)
            
            questionArray.append(question)
        }
        
        if currentStepNumber == 0 {
            backAndForwardBar.previousButton.isEnabled = false
        } else {
            backAndForwardBar.previousButton.isEnabled = true
        }
        if currentStepNumber == localStepsArray.count-1 {
            let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
            let previousArrow = UIImage(systemName: "arrow.left.circle.fill", withConfiguration: config)
            backAndForwardBar.nextButton.setImage(previousArrow, for: .normal)
        }
        self.numberOfQuestionsInStep = localStepsArray[self.currentStepNumber].questionTitles.count
        self.questionsView.reloadData()
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([questionsView.topAnchor.constraint(equalTo: wspTitleLabel.bottomAnchor),
                                     questionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                                     questionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                                     questionsView.bottomAnchor.constraint(equalTo: backAndForwardBar.topAnchor)])
        
        NSLayoutConstraint.activate([backAndForwardBar.topAnchor.constraint(equalTo: questionsView.bottomAnchor),
                                     backAndForwardBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     backAndForwardBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     backAndForwardBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                                     backAndForwardBar.heightAnchor.constraint(equalToConstant: 80)])
    }
    
    internal func getQuestions(completion: @escaping (Bool, Forms?, FormMO?, Error?) -> Void) {
        
        
        if isNewLogbookItem {
            if let path = Bundle.main.path(forResource: "wsp", ofType: "json") {
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let form = try? JSONDecoder.camelCaseJSONDecoder.decode(Forms.self, from: jsonData)
                    if let form = form {
                        completion(true, form, nil, nil)
                    }
                    
                } catch {
                    completion(false, nil, nil, error)
                }
            }
        } else {
            if let steps = logbookItem?.stepsArray {
                print(steps[currentStepNumber].questionsArray[0].title)
            }
        }
    }
}

extension WSPViewController {
    
}

extension WSPViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfQuestionsInStep
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WSPCell", for: indexPath) as! WSPTableViewCell
        cell.delegate = self
        
        cell.yesButton.tintColor = .systemGray
        cell.noButton.tintColor = .systemGray
        
        cell.question = questionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WSPViewController: WSPTableViewCellDelegate {
    func yesButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell) {
        button.tintColor = .systemBlue
        
        guard let questionFromCell = cell.question else { return }
        if let indexOfQuestion = questionArray.firstIndex(of: questionFromCell) {
            questionArray[indexOfQuestion] = questionFromCell
        }
    }
    
    func noButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell) {
        button.tintColor = .systemRed
        guard let questionFromCell = cell.question else { return }
        if let indexOfQuestion = questionArray.firstIndex(of: questionFromCell) {
            questionArray[indexOfQuestion] = questionFromCell
        }
    }
    
    func saveQuestions(ofThis _currentStepNumber: Int, _ _questionArray: [QuestionMO]) {
        let stepInLogbook = StepMO(context: context)
        stepInLogbook.title = localStepsArray[_currentStepNumber].title
        stepInLogbook.order = Int32(_currentStepNumber)
        
        for question in _questionArray {
            question.addToStep(stepInLogbook)
        }
        
        guard let logbookItem = logbookItem else { return }
        stepInLogbook.addToForm(logbookItem)
    }
}

extension WSPViewController: ButtonBarViewDelegate {
    func nextButtonTapped(_ button: UIButton) {
        
        saveQuestions(ofThis: self.currentStepNumber, questionArray)
        
        self.currentStepNumber += 1
        if currentStepNumber < localStepsArray.count {
            questionArray = []
            setupForm()
        }
        if currentStepNumber == localStepsArray.count {
            CoreDataStack.instance.saveContext()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func previousButtonTapped(_ button: UIButton) {
    }
}
