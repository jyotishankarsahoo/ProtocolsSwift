//
//  Student.swift
//  ProtocolDelegatePattern
//
//  Created by jyoti shankar sahoo on 12/9/18.
//  Copyright © 2018 jyoti shankar sahoo. All rights reserved.
//

import Foundation
protocol StudentDelegate: class {
    func update(_ student: Student, index: Int)
    func add(_ student: Student)
}

struct Student {
    var name: String
    var grade: String
    var phoneNumber: String
    var parentName: String
}
