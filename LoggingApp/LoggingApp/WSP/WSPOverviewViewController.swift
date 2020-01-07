//
//  WSPOverviewViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 03/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class WSPOverviewViewController: UIViewController {
    
    private lazy var tableView : UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CoreDataStack.instance.fetchForms()
        tableView.register(UINib(nibName: "WSPOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "WSPOverviewCell")
        
        view.addSubview(tableView)
        setupConstraints()
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "formSelectedSegue", let destination = segue.destination as? WSPViewController {
            let form = sender as! FormMO
            destination.logbookItem = form
            destination.isNewLogbookItem = false
        }
    }

}

extension WSPOverviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataStack.instance.fetchedWSPs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WSPOverviewCell", for: indexPath) as! WSPOverviewTableViewCell
        cell.titleLabel.text = "dikke niks"
        cell.createAtLabel.text = CoreDataStack.instance.fetchedWSPs[indexPath.row].createdAt?.toString(dateFormat: "HH:MM dd-MM-yyyy")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedForm = CoreDataStack.instance.fetchedWSPs[indexPath.row]
        performSegue(withIdentifier: "formSelectedSegue", sender: selectedForm)
    }
    
    
}
