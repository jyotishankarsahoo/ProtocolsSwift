//
//  ViewController.swift
//  ProtocolDelegatePattern
//
//  Created by jyoti shankar sahoo on 12/9/18.
//  Copyright © 2018 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var parentNameField: UITextField!
    weak var delegate: StudentDelegate?

    var studentDetail: Student?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        if studentDetail == nil {
            studentDetail = Student(name: nameField.text ?? "Test", grade: gradeField.text ?? "5", phoneNumber: phoneNumberField.text ?? "", parentName: parentNameField.text ?? "")
            if let student = studentDetail {
                delegate?.add(student)
            }
        } else {
            studentDetail?.name = nameField.text ?? "Test"
            studentDetail?.grade = gradeField.text ?? "6"
            studentDetail?.parentName = parentNameField.text ?? ""
            studentDetail?.phoneNumber = phoneNumberField.text ?? ""
            
            if let student = studentDetail, let studentIndex = index {
                delegate?.update(student, index: studentIndex)
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }

    func populateView() {
        guard let student = studentDetail else { return }
        nameField.text = student.name
        gradeField.text = student.grade
        phoneNumberField.text = student.phoneNumber
        parentNameField.text = student.parentName
    }

}

