//
//  ViewController.swift
//  fienlute-pset4
//
//  Created by Fien Lute on 20-11-16.
//  Copyright © 2016 Fien Lute. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var addButton: UIButton!
  
    
    // internet
    private var NewTodos = [TodoList]()
    private var selectedNewTodo: Int?
    //

    private let db = DatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if db == nil {
            print("Error")
        }
        
        NewTodos = DatabaseHelper.instance!.getTodo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            selectedNewTodo = indexPath.row
            try db!.deleteTodo(cid: NewTodos[selectedNewTodo!].id!)
            NewTodos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    @IBAction func addAction(_ sender: Any) {
        
       // tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: NewTodos.count-1, inSection: 0)], withRowAnimation: .Fade)

        do {
            try db!.addTodo(task: userInput.text!)
            NewTodos = DatabaseHelper.instance!.getTodo()
            tableView.reloadData()
        } catch {
            print(error)
        }
    }

    
    // internet
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userInput.text = NewTodos[indexPath.row].task
        
        selectedNewTodo = indexPath.row
    }
    
    // demo stuff and internet
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        var labelTodo: UILabel?
        labelTodo = cell.viewWithTag(1) as? UILabel
        cell.labelTodo?.text = NewTodos[indexPath.row].task
        // cell.labelTodo.text = NewTodos[indexPath.row]
        
        return cell
        
    }

    
}

