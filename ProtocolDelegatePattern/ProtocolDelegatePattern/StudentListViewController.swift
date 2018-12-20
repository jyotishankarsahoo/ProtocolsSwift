//
//  StudentListViewController.swift
//  ProtocolDelegatePattern
//
//  Created by jyoti shankar sahoo on 12/9/18.
//  Copyright © 2018 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class StudentListViewController: UITableViewController {

    var students: [Student] = [
        Student(name: "Jack", grade: "A", phoneNumber: "4083323363", parentName: "Mochale"),
        Student(name: "Henny", grade: "B", phoneNumber: "4083657363", parentName: "Rover"),
        Student(name: "Steave", grade: "A", phoneNumber: "4567323363", parentName: "Hillary")]

    var selectedStudentInfo: Student?

    enum Identifiers {
        static let  studentListCell = "studentListCell"
        static let detailedView = "studentDetailedView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.studentListCell, for: indexPath)
        let studentModel = students[indexPath.row]
        cell.textLabel?.text = studentModel.name
        cell.detailTextLabel?.text = studentModel.grade
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudentInfo = students[indexPath.row]
        performSegue(withIdentifier: Identifiers.detailedView, sender: self)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailedViewController = segue.destination as? DetailedViewController, segue.identifier == Identifiers.detailedView {
            detailedViewController.studentDetail = selectedStudentInfo
            detailedViewController.index = tableView.indexPathForSelectedRow?.row
            detailedViewController.delegate = self
        }
    }

}

extension StudentListViewController: StudentDelegate {

    func update(_ student: Student, index: Int) {
        students[index] = student
        tableView.reloadData()
    }

    func add(_ student: Student) {
        students.append(student)
        tableView.reloadData()
    }

}
