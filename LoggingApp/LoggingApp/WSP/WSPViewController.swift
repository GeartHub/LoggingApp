//
//  WSPViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 10/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

class WSPViewController: UIViewController {
    
    var numberOfQuestionsInStep = 0
    var currentStepNumber = 0
    var currentQuestionNumber = 0
    
    var aircraft: AircraftMO?
    var logbookItem: FormMO?
    let context = CoreDataStack.instance.managedObjectContext
    var formTemplate: FormTemplate?
    
    private lazy var questionsView : UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
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
        
        if logbookItem != nil {
            formTemplate = FormTemplate(formType: .answered, form: logbookItem)
        } else {
            formTemplate = FormTemplate.init(formType: .new)
        }
        
        setupForm()
        // Do any additional setup after loading the view.
    }
    
    func setupForm () {
        
        if currentStepNumber == 0 {
            backAndForwardBar.previousButton.isEnabled = false
        } else {
            backAndForwardBar.previousButton.isEnabled = true
        }
        guard let form = formTemplate?.form else { return }
        if currentStepNumber == form.stepsArray.count-1{
            let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
            let previousArrow = UIImage(systemName: "arrow.left.circle.fill", withConfiguration: config)
            backAndForwardBar.nextButton.setImage(previousArrow, for: .normal)
        }
        self.questionsView.reloadData()
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([questionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     questionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                                     questionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                                     questionsView.bottomAnchor.constraint(equalTo: backAndForwardBar.topAnchor)])
        
        NSLayoutConstraint.activate([backAndForwardBar.topAnchor.constraint(equalTo: questionsView.bottomAnchor),
                                     backAndForwardBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     backAndForwardBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     backAndForwardBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                                     backAndForwardBar.heightAnchor.constraint(equalToConstant: 80)])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddParticularitiesSegue", let destination = segue.destination as? AddParticularitiesViewController {
            guard let cell = sender as? WSPTableViewCell else { return }
            destination.question = cell.question
            destination.delegate = self
        }
    }
}

extension WSPViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formTemplate?.form?.stepsArray[currentStepNumber].questionsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WSPCell", for: indexPath) as! WSPTableViewCell
        cell.delegate = self
        
        if let question = formTemplate?.form?.stepsArray[currentStepNumber].questionsArray[indexPath.row] {
            if question.particularities != nil {
                cell.particularityHeightConstraint.constant = 27
                UIView.animate(withDuration: 0.25, animations: {
                    cell.layoutIfNeeded()
                })
            }
            cell.question = question
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WSPViewController: WSPTableViewCellDelegate {
    func yesButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell) {
        button.tintColor = .systemBlue
        
//        guard let questionFromCell = cell.question else { return }
//        if let indexOfQuestion = formTemplate?.form?.stepsArray[currentStepNumber].questionsArray.firstIndex(of: questionFromCell) {
//            formTemplate?.form?.stepsArray[currentStepNumber].questionsArray[indexOfQuestion].options = questionFromCell.options
//        }
    }
    
    func noButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell) {
        button.tintColor = .systemRed
    }
}

extension WSPViewController: ButtonBarViewDelegate {
    func nextButtonTapped(_ button: UIButton) {
        
        self.currentStepNumber += 1
        if currentStepNumber < formTemplate?.form?.stepsArray.count ?? 0 {
            setupForm()
        }
        if currentStepNumber == formTemplate?.form?.stepsArray.count ?? 0 {
            if formTemplate?.type == .new {
                guard let aircraft = self.aircraft else { return }
                formTemplate?.form?.addToAircraft(aircraft)
                CoreDataStack.instance.saveContext()
            }
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func previousButtonTapped(_ button: UIButton) {
        self.currentStepNumber -= 1
        setupForm()
    }
    
    func addParticularityButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell) {
        performSegue(withIdentifier: "AddParticularitiesSegue", sender: cell)
    }
}

extension WSPViewController: AddParticularitiesViewControllerDelegate {
    func doneButtonTapped(_ sender: Any) {
        questionsView.reloadData()
    }
    
    
}
