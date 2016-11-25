//
//  NewTodo.swift
//  fienlute-pset4
//
//  Created by Fien Lute on 23-11-16.
//  Copyright © 2016 Fien Lute. All rights reserved.
//

import Foundation

class TodoList {
    let id: Int64?
    var task: String
    var check: Bool
    
    init(id: Int64) {
        self.id = id
        task = ""
        self.check = false
    }
    
    init(id: Int64, task: String, check: Bool) {
        self.id = id
        self.task = task
        self.check = check
    }
 
}

