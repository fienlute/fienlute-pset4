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
    
    init(id: Int64) {
        self.id = id
        task = ""
    }
    
    init(id: Int64, task: String) {
        self.id = id
        self.task = task
            }
}

