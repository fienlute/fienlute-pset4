//
//  DatabaseHelper.swift
//  fienlute-pset4
//
//  Created by Fien Lute on 22-11-16.
//  Copyright © 2016 Fien Lute. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    private let todo = Table("todo")
    
    private let id = Expression<Int64>("id")
    private let task = Expression<String?>("task")
    
    private var db: Connection?
    
    init?() {
        do {
           try setupDatabase()
        } catch {
            print(error)
            return nil
        }
    }
    
    private func setupDatabase() throws {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        // first is for first element out of array 
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        } catch {
            throw error
        }
    }
    
    private func createTable() throws {
        
        do{
            try db!.run(todo.create(ifNotExists: true) {
                t in
                
                t.column(id, primaryKey: .autoincrement)
                t.column(task)
            })
        } catch{
            throw error
        }
    }
    
    func addAction(task: String) throws {
        
        let insert = todo.insert(self.task <- task)
        
        // not sure if needed cause unique
        do {
            let rowId  = try db!.run(insert)
            print (rowId)
        } catch {
            throw error
        }
        
    }

}
