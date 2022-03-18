//
//  PetsViewController.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/19.
//

import UIKit

class PetsViewController: UITableViewController {
    var petList: PetList!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.pets.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath) as! PetCell
        cell.name.text = petList.pets[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        petList.movePet(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = petList.pets[indexPath.row]
            petList.removePet(item: item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addNew":
            let addNew = segue.destination as! AddNewViewController
            addNew.petList = petList
        case "showDetail":
            if let row = tableView.indexPathForSelectedRow?.row {
                let symptomList = segue.destination as! SymptomSelectionViewController
                symptomList.pet = petList.pets[row]
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
