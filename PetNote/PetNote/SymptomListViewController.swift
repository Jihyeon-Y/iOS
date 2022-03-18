//
//  SymptomListViewController.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/22.
//

import UIKit

class SymptomListViewController: UITableViewController {
    var symptom: Symptom!
    var symptomLogs = [SymptomLog]()
    var gender: Int = 0
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomLogs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath)
        cell.imageView?.image = UIImage(named: symptomLogs[indexPath.row].symptom)
        if gender == 0 {
            cell.textLabel?.text = "He \(symptomLogs[indexPath.row].symptom)"
        } else {
            cell.textLabel?.text = "She \(symptomLogs[indexPath.row].symptom)"
        }
        cell.detailTextLabel?.text = "on \(symptomLogs[indexPath.row].timestamp.formatted(date: .numeric, time: .shortened))."
        return cell
    }
}
extension SymptomListViewController: SymptomConfigurable {
    func add(symptomLog: SymptomLog) {
        symptomLogs.insert(symptomLog, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
