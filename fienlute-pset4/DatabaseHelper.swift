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
    
    private let NewTodos = Table("NewTodos")
    
    private let id = Expression<Int64>("id")
    private let task = Expression<String?>("task")
    private let check = Expression<Bool>("check")
    
    static let instance = DatabaseHelper()
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
            db = try Connection("\(path)/db3.sqlite3")
            try createTable()
        } catch {
            throw error
        }
        
        // try createTable()
    }
    
    private func createTable() throws {
        
        do{
            try db!.run(NewTodos.create(ifNotExists: true) {
                t in
                
                t.column(id, primaryKey: .autoincrement)
                t.column(task)
                t.column(check)
            })
        } catch{
            throw error
        }
    }
    
    func addTodo(task: String) throws {
        
        do {
            let insert = NewTodos.insert(self.task <- task, check <- false)
            let task = try db!.run(insert)
            print (task)
        } catch {
            throw error
        }
    }
    
    func getTodo() -> [TodoList] {
        var NewTodos = [TodoList]()
        
        do {
            for NewTodo in try db!.prepare(self.NewTodos) {
                NewTodos.append(TodoList(id: NewTodo[id], task: NewTodo[task]!, check: NewTodo[check]))
            }
        } catch {
            print("Select failed")
        }
        
        return NewTodos
    }
    
    func deleteTodo(cid: Int64) -> Bool {
        do {
            let NewTodo = NewTodos.filter(id == cid)
            try db!.run(NewTodo.delete())
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
    func updateSwitch(name: String, newCheck: Bool) {
        do {
        
            let item = NewTodos.filter(task == name)
            try db!.run(item.update(check <- newCheck))
        }
        catch {
            print("update failed")
        }
    }
    
    
        

}
